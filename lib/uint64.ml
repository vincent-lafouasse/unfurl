(* big endian bytes, always 8 characters *)
type t = string

let zero : t = String.make 8 '\000'
let max_int : t = String.make 8 '\255'

let compare = String.compare
let equal = String.equal

(* just reinterpret the bits *)
let to_i64 (u : t) : int64 = String.get_int64_be u 0

let to_string u = Printf.sprintf "%Lu" (to_i64 u)
let pp fmt u = Format.fprintf fmt "%Lu" (to_i64 u)

let of_int64 (i : int64) : t =
  let b = Bytes.create 8 in
  Bytes.set_int64_be b 0 i;
  Bytes.unsafe_to_string b
;;

let of_int i = if i < 0 then None else Some (of_int64 (Int64.of_int i))

let u64_max_str = "18446744073709551615"

let compare_decimal (a : string) (b : string) : int =
  match Int.compare (String.length a) (String.length b) with
  | 0 -> String.compare a b
  | c -> c
;;

(* s * 10 + d, one byte at a time from the least significant one.
   v <= 255 * 10 + 9 so it always fits in an int.
   cannot overflow if s <= u64_max_str, hence the assert *)
let digits_to_bytes (s : string) : t =
  let b = Bytes.make 8 '\000' in
  let push_digit c =
    let carry = ref (Char.code c - Char.code '0') in
    for i = 7 downto 0 do
      let v = (Bytes.get_uint8 b i * 10) + !carry in
      Bytes.set_uint8 b i (v land 0xFF);
      carry := v lsr 8
    done;
    assert (!carry = 0)
  in
  String.iter push_digit s;
  Bytes.unsafe_to_string b
;;

let of_digits s =
  let will_overflow = compare_decimal s u64_max_str > 0 in
  if will_overflow then None else Some (digits_to_bytes s)
;;

(* Int64's unsigned functions serve as the oracle *)
let%test_module "uint64" =
  (module struct
    (* 0, 255, 256, 2^32 - 1, 2^32, 2^63 - 1, 2^63, 2^64 - 1 *)
    let raws =
      [ 0L; 255L; 256L; 0xFFFF_FFFFL; 0x1_0000_0000L; Int64.max_int; Int64.min_int; -1L ]
    ;;
    let us = List.map of_int64 raws
    let sign n = Int.compare n 0

    let%test "always 8 bytes" = List.for_all (fun u -> String.length u = 8) us
    let%test "zero" = to_string zero = "0"
    let%test "max_int" = to_string max_int = "18446744073709551615"
    let%test "of_int64 0 is zero" = equal (of_int64 0L) zero
    let%test "of_int64 -1 is max_int" = equal (of_int64 (-1L)) max_int

    let%test "big endian" =
      of_int64 0x0102_0304_0506_0708L = "\001\002\003\004\005\006\007\008"
    ;;

    let%test "to_i64 inverts of_int64" =
      List.for_all (fun r -> Int64.equal (to_i64 (of_int64 r)) r) raws
    ;;

    let%test "to_string matches %Lu" =
      List.for_all2 (fun r u -> to_string u = Printf.sprintf "%Lu" r) raws us
    ;;

    let%test "compare matches unsigned_compare" =
      List.for_all2
        (fun ra ua ->
           List.for_all2
             (fun rb ub -> sign (compare ua ub) = sign (Int64.unsigned_compare ra rb))
             raws
             us)
        raws
        us
    ;;

    let%test "polymorphic compare agrees" =
      List.for_all
        (fun a ->
           List.for_all (fun b -> sign (Stdlib.compare a b) = sign (compare a b)) us)
        us
    ;;

    let%test "of_digits round trips to_string" =
      List.for_all (fun u -> of_digits (to_string u) = Some u) us
    ;;

    let%test "of_digits at the u64 boundary" =
      of_digits "18446744073709551615" = Some max_int
      && of_digits "18446744073709551616" = None
      && of_digits "99999999999999999999" = None
      && of_digits "100000000000000000000" = None
    ;;

    let%test "of_digits below 20 digits" =
      of_digits "0" = Some zero
      && Option.map to_string (of_digits "9999999999999999999")
         = Some "9999999999999999999"
    ;;

    let%test "pp matches to_string" =
      List.for_all (fun u -> Format.asprintf "%a" pp u = to_string u) us
    ;;

    let%test "of_int rejects negatives" =
      of_int (-1) = None && of_int Stdlib.min_int = None
    ;;

    let%test "of_int" =
      List.for_all
        (fun n -> Option.map to_string (of_int n) = Some (string_of_int n))
        [ 0; 1; 255; 256; Stdlib.max_int ]
    ;;
  end)
;;
