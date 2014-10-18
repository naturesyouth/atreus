#lang racket

(define cols 12)
(define rows 4)

(define x-offset 30)
(define y-offset 30)

(define spacing 19)
(define angle 10)

(define offsets '(8 5 0 6 11 59 59 11 6 0 5 8))

(define (switch-module x y rotation label net-pos net-neg)
  ;; TODO: set timestamps?
  `(module MX_FLIP (layer Front) (tedit 4FD81CDD) (tstamp 543EF801)
    (at ,x ,y ,rotation)
    (path /543DB910) ; TODO: this is not documented; no idea what it does
    (fp_text reference ,label (at 0 3.302) (layer F.SilkS)
             (effects (font (size 1.524 1.778) (thickness 0.254))))
    (fp_line (start -6.35 -6.35) (end 6.35 -6.35)
             (layer Cmts.User) (width 0.381))
    (fp_line (start 6.35 -6.35) (end 6.35 6.35)
             (layer Cmts.User) (width 0.381))
    (fp_line (start 6.35 6.35) (end -6.35 6.35)
             (layer Cmts.User) (width 0.381))
    (fp_line (start -6.35 6.35) (end -6.35 -6.35)
             (layer Cmts.User) (width 0.381))
    (pad 0 np_thru_hole circle (at 0 0) (size 3.9878 3.9878)
         (drill 3.9878) (layers *.Cu)) ; switch hole, no copper
    (pad 0 thru_hole circle (at -5.08 0) (size 1.7018 1.7018)
         (drill 1.7018) (layers *.Cu)) ; board-mount hole, no copper
    (pad 0 thru_hole circle (at 5.08 0) (size 1.7018 1.7018)
         (drill 1.7018) (layers *.Cu)) ; board-mount hole, no copper
    (pad 1 thru_hole circle (at 2.54 -5.08) (size 2.286 2.286) (drill 1.4986)
         (layers *.Cu *.SilkS *.Mask) ,net-pos)
    (pad 1 thru_hole circle (at 3.81 -2.54) (size 2.286 2.286) (drill 1.4986)
         (layers *.Cu *.SilkS *.Mask) ,net-pos)
    (pad 2 thru_hole circle (at -2.54 -5.08) (size 2.286 2.286) (drill 1.4986)
         (layers *.Cu *.SilkS *.Mask) ,net-neg)
    (pad 2 thru_hole circle (at -3.81 -2.54) (size 2.286 2.286) (drill 1.4986)
         (layers *.Cu *.SilkS *.Mask) ,net-neg)))

(define (diode-module x y rotation label net-pos net-neg)
  `(module DIODE (layer Front) (tedit 4E0F7A99) (tstamp 543EF854)
    (at ,x ,y ,(+ 180 rotation))
    (path /543DB90F)
    (fp_text reference D2:2 (at 0 0 180) (layer F.SilkS) hide
             (effects (font (size 1.016 1.016) (thickness 0.2032))))
    (fp_line (start -1.524 -1.143) (end 1.524 -1.143)
             (layer Cmts.User) (width 0.2032))
    (fp_line (start 1.524 -1.143) (end 1.524 1.143)
             (layer Cmts.User) (width 0.2032))
    (fp_line (start 1.524 1.143) (end -1.524 1.143)
             (layer Cmts.User) (width 0.2032))
    (fp_line (start -1.524 1.143) (end -1.524 -1.143)
             (layer Cmts.User) (width 0.2032))
    (fp_line (start -3.81 0) (end -1.6637 0) (layer Back) (width 0.6096))
    (fp_line (start 1.6637 0) (end 3.81 0) (layer Back) (width 0.6096))
    (fp_line (start -3.81 0) (end -1.6637 0) (layer Front) (width 0.6096))
    (fp_line (start 1.6637 0) (end 3.81 0) (layer Front) (width 0.6096))

    (pad 1 thru_hole circle (at -3.81 0 180) (size 1.651 1.651)
         (drill 0.9906) (layers *.Cu *.SilkS *.Mask) ,net-pos)
    (pad 2 thru_hole rect (at 3.81 0 180) (size 1.651 1.651)
         (drill 0.9906) (layers *.Cu *.SilkS *.Mask) ,net-neg)
    (pad 99 smd rect (at -1.6637 0 180) (size 0.8382 0.8382)
         (layers Front F.Paste F.Mask))
    (pad 99 smd rect (at -1.6637 0 180) (size 0.8382 0.8382)
         (layers Back B.Paste B.Mask))
    (pad 99 smd rect (at 1.6637 0 180) (size 0.8382 0.8382)
         (layers Front F.Paste F.Mask))
    (pad 99 smd rect (at 1.6637 0 180) (size 0.8382 0.8382)
         (layers Back B.Paste B.Mask))))

(define teensy-module
  `(module TEENSY_2.0 (layer Front) (tedit 4FDC31C8) (tstamp 543EF800)
    (at 135.9281 51.3207 270)
    (path /543EEB02)
    (fp_text value TEENSY2.0 (at 0 0 270) (layer F.SilkS)
             (effects (font (size 3.048 2.54) (thickness 0.4572))))
    (fp_line (start -15.24 -8.89) (end -15.24 8.89) (layer Dwgs.User) (width 0.381))
    (fp_line (start -15.24 8.89) (end 15.24 8.89) (layer Dwgs.User) (width 0.381))
    (fp_line (start 15.24 8.89) (end 15.24 -8.89) (layer Dwgs.User) (width 0.381))
    (fp_line (start 15.24 -8.89) (end -15.24 -8.89) (layer Dwgs.User) (width 0.381))
    (fp_line (start 0 0) (end 0 0) (layer Dwgs.User) (width 0.0254))
    (fp_line (start -15.24 -8.89) (end -15.24 8.89) (layer Cmts.User) (width 0.381))
    (fp_line (start -15.24 8.89) (end 15.24 8.89) (layer Cmts.User) (width 0.381))
    (fp_line (start 15.24 8.89) (end 15.24 -8.89) (layer Cmts.User) (width 0.381))
    (fp_line (start 15.24 -8.89) (end -15.24 -8.89) (layer Cmts.User) (width 0.381))
    (fp_line (start -15.24 -8.89) (end -15.24 8.89) (layer F.SilkS) (width 0.381))
    (fp_line (start -15.24 8.89) (end 15.24 8.89) (layer F.SilkS) (width 0.381))
    (fp_line (start 15.24 8.89) (end 15.24 -8.89) (layer F.SilkS) (width 0.381))
    (fp_line (start 15.24 -8.89) (end -15.24 -8.89) (layer F.SilkS) (width 0.381))
    (fp_line (start -15.24 6.35) (end -12.7 6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start -12.7 6.35) (end -12.7 8.89) (layer F.SilkS) (width 0.381))

    ;; Should the placements be determined by a formula?
    (pad 1 thru_hole rect (at -13.97 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 2 thru_hole circle (at -11.43 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 3 thru_hole circle (at -8.89 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 4 thru_hole circle (at -6.35 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 22 N-000030))
    (pad 5 thru_hole circle (at -3.81 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 12 N-000019))
    (pad 6 thru_hole circle (at -1.27 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 17 N-000025))
    (pad 7 thru_hole circle (at 1.27 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 8 thru_hole circle (at 3.81 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 3 N-000003))
    (pad 9 thru_hole circle (at 6.35 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 54 N-000073))
    (pad 10 thru_hole circle (at 8.89 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 53 N-000071))
    (pad 11 thru_hole circle (at 11.43 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 12 thru_hole circle (at 13.97 7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 18 thru_hole circle (at 13.97 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 19 thru_hole circle (at 11.43 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 20 thru_hole circle (at 8.89 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 55 N-000074))
    (pad 21 thru_hole circle (at 6.35 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 56 N-000075))
    (pad 22 thru_hole circle (at 3.81 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 57 N-000076))
    (pad 23 thru_hole circle (at 1.27 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 48 N-000066))
    (pad 24 thru_hole circle (at -1.27 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 6 N-000006))
    (pad 27 thru_hole circle (at -8.89 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 28 N-000037))
    (pad 28 thru_hole circle (at -11.43 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 29 thru_hole circle (at -13.97 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
    (pad 25 thru_hole circle (at -3.81 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 32 N-000041))
    (pad 26 thru_hole circle (at -6.35 -7.62 270) (size 1.7526 1.7526)
         (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 46 N-000064))))

(define current-net (box 0))
(define (net label number)
  (set-box! current-net (+ (unbox current-net) 1))
  (list 'net (unbox current-net)
        (string->symbol (format "N-~a-~a" label number))))

(define nets
  (append (list '(net 0 ""))
          ;; TODO: this causes a pcbnew segfault
          ;; (for/list ([row (in-range rows)])
          ;;   (net "row" row))
          ;; (for/list ([col (in-range cols)])
          ;;   (net "col" col))
          ;; (for/list ([d (- (* rows cols) 2)])
          ;;   (net "diode" d))
          ))

(define (net-class nets)
  (append '(net_class Default "This is the default net class."
            (clearance 0.254)
            (trace_width 0.2032)
            (via_dia 0.889)
            (via_drill 0.635)
            (uvia_dia 0.508)
            (uvia_drill 0.127))
          (for/list ([n nets])
            (list 'add_net (last n)))))

(define (switch row col)
  ;; TODO: need trig here:
  (let ([x (+ x-offset (* col spacing))]
        [y (+ (* row spacing) (list-ref offsets col) y-offset)]
        [rotation (if (< 5 col) 10 -10)]
        [label (format "~a:~a" col row)])
    ;; TODO: diode/column nets
    (switch-module x y rotation label '(net 0 "") '(net 0 ""))))

(define (diode row col)
  ;; TODO: need trig here:
  (let ([x (+ x-offset (* col spacing) -1)]
        [y (+ (* row spacing) (list-ref offsets col) y-offset 4)]
        [rotation (if (< 5 col) 10 -10)]
        [label (format "~a:~a" col row)])
    ;; TODO: diode/row nets
    (diode-module x y rotation label '(net 0 "") '(net 0 ""))))

(define switches+diodes
  (for/list ([col (in-range cols)]
             #:when true
             [row (if (or (= 5 col) (= 6 col))
                      '(0) (in-range rows))])
    (list (switch row col) (diode row col))))

(define board
  (apply append nets
         (list (net-class nets))
         (list teensy-module)
         switches+diodes))

(define (write-placement filename)
  (when (file-exists? filename) (delete-file filename))
  (call-with-output-file filename
    (λ (op)
      (display (call-with-input-file "header.rktd"
                 (curry read-string 9999)) op)
      ;; kicad has this terrible bug where it's whitespace-sensitive here =(
      (display "\n" op)
      (for ([f board])
        (pretty-print f op 1))
      (display ")" op))))

;; (write-placement "/tmp/atreus.kicad_pcb")
