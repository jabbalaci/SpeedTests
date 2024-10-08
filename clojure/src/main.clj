(ns main
  (:gen-class))

(set! *unchecked-math* true)

(def ^:const max-n 440000000)

(def ^longs cache (long-array (map #(if (= % 0) 0 (Math/pow % %))
                                   (range 0 10))))

(defn munchausen? [^long num ^longs cache]
  (loop [n num
         total 0]
    (cond (> total num) false
          (> n 0) (recur (quot n 10)
                         (+ total (aget cache (rem n 10))))
          :else (= num total))))

(defn -main []
  (loop [i 0]
    (cond (munchausen? i cache) (do (println i)
                                    (recur (inc i)))
          (< i max-n) (recur (inc i)))))
