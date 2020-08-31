namespace RanGen {
    // essential libraries
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    
    // generate a random qubit
    operation GenerateRandomQubit() : Result {
        using (q = Qubit()) {   // allocate a qubit
            H(q);               // superposition
            return MResetZ(q);  // measure qubit value
        }
    }

    // set min value to 0 if it is negative
    operation IsMinNumNeg(min : Int) : Int {
        mutable minNumber = min;    // create a variable which is equal to min value
        if(minNumber < 0) {         // set min to 0 if it is negative
            set minNumber = 0;
        }
        return minNumber;
    }

    // generate random number
    operation RandomNumberInRange(min : Int, max : Int) : Int {
        mutable output = 0;                     // create output variable as 0
        repeat {                                // repeat this process until min <= output <= max cond.
            mutable bits = new Result[0];       // create bits result array for storing bits 
            for(qBits in 1..BitSizeI(max)) {    
                set bits += [GenerateRandomQubit()];  // generate random qubits and storing them in bits array
            }
            set output = ResultArrayAsInt(bits);  // convert bits array to decimal value
        } until (output <= max and output >= min);
        return output;  // return random generated number
    }

    @EntryPoint()
    operation RandomNumberGenerator() : Int {
        let max = 100;               // determine max value for range
        mutable min = -100;          // determine min value for range
        set min = IsMinNumNeg(min);  // change min value if it is negative
        Message($"Random number between {min} and {max}: ");  // print for info
        return RandomNumberInRange(min, max);  // return random generated number
    }
}
