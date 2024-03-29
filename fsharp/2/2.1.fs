﻿namespace Second

module First =
    let numer (x: int * int) =
        let (numer, _) = x
        numer

    let denom (x: int * int) =
        let (_, denom) = x
        denom

    let rec gcd a b = if b = 0 then a else gcd b (a % b)

    let makeRat a b =
        let isNegative = a * b < 0
        let (c, d) = ((abs a), (abs b))
        let g = gcd c d

        if isNegative then
            (-c / g, d / g)
        else
            (c / g, d / g)
