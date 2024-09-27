(set! *compile-path* "./classes")
(binding [*compiler-options* {:direct-linking true}]
  (compile 'main))
