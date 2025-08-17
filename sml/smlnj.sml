use "munchausen.sml" ;;
SMLofNJ.exportFn ("exec", fn (_, _) => (
  main () ;
  OS.Process.exit OS.Process.success
))
