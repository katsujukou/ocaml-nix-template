open Helloworld

let test_greet () = assert (Mylib.greet "John" = "Hello, John!🐪")

let () =
  let open Alcotest in
  run "Mylib" [ ("greet-function", [ test_case "unit" `Quick test_greet ]) ]
