namespace XWasHere.Random {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation RandBit() : Result {
        // init qbit
        use r = Qubit();
        
        // place in superposition;
        H(r);

        // qbit can now be 1 or 0, 50/50 chance
        // measure qbit
        return M(r);
    }

    operation RandInt(max: Int) : Int {
        // init output
        mutable output = 0;
        repeat {
            // init bit array
            mutable bits = new Result[0];
            for idxBit in 1..BitSizeI(max) {
                set bits += [RandBit()]; 
            }
            set output = ResultArrayAsInt(bits);
        } until (output <= max);
        // return number
        return output;
    }
}

namespace quantum {
    open XWasHere.Random;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation Main() : Int {
        Message("Random number between 1 and 10");
        return RandInt(10);
    }
}
