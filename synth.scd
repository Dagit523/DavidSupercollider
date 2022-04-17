

Server.default.options.device_("Scarlett 2i2 USB");
Server.default.record;

(
SynthDef(\bass, { | modFreq = 100, modFreq2 = 66, freq = 55|

	var output, ringMod, freqMod, carry;
	ringMod = SinOsc.ar(modFreq);
	freqMod = Pulse.ar(modFreq2, 0.5, 20, 40);
	carry = Saw.ar(freq + freqMod);
	output = (carry * ringMod) * 0.5;
	~env = Env([0, 1, 0.5, 0], [0.1, 1, 2]);
	output = output * EnvGen.ar(~env, doneAction: 2);
	Out.ar(0, output);

}).add;
)

(
SynthDef(\bass2, { | modFreq, modFreq2, freq |

	var output, ringMod, freqMod, carry;
	ringMod = Pulse.ar(modFreq);
	freqMod = Saw.ar(modFreq2, 0.5, 20, 40);
	carry = SinOsc.ar(freq + freqMod);
	output = (carry * ringMod) * 0.5;
	~env = Env([0, 1, 0.5, 0], [0.1, 1, 2]);
	output = output * EnvGen.ar(~env, doneAction: 2);
	Out.ar(1, output);

}).add;
)

(
SynthDef(\guitarSynth, {

	var freq1, freq2, freq3, freq4, freq5, output, mod1, mod2, carry1, carry2, carrySum;
	var input = AudioIn.ar(2);
	var fftA = FFT(LocalBuf((2048), 1), input);
	freq1 = SpecPcile.kr(fftA, 0.9) - 100;
	freq2 = SpecPcile.kr(fftA, 0.7) - 100;
	freq3 = SpecPcile.kr(fftA, 0.5) - 100;
	freq4 = SpecPcile.kr(fftA, 0.3) - 100;
	freq5 = SpecPcile.kr(fftA, 0.1) - 100;
	mod1 = SinOsc.ar(freq1);
	mod2 = LFTri.ar(freq2);
	carry1 = Saw.ar(freq3 + mod1 - mod2);
	output = carry1 * SinOsc.ar(freq5, 0.0, 1.0, 1);
	output = output * 0.6;
	output = LPF.ar(output, 1500);
	Out.ar(0, output);
	Out.ar(1, output);

}).add;
)

(
SynthDef(\fibo, { | freq = 60, numFibs = 10, amp = 1, spread = 1 |

	var snd, mod, lfo, freqA, freqB, freqC, fftA;
	var input = AudioIn.ar(2); // first input
	fftA = FFT(LocalBuf((2048), 1), input);
	freqA = SpecPcile.kr(fftA, 0.7);
	freqB = SpecPcile.kr(fftA, 0.3);
	freqC = SpecPcile.kr(fftA, 0.1);
	lfo = SinOsc.kr(freqB).range(1, 20);
	mod = LFTri.ar( lfo, mul: 12pi);
	snd = IFFT(fftA) * (SinOsc.ar(freqA *  Array.fib(10, 0, 1, 44, 43, 32), mod) * 1) * SinOsc.ar(freqC);
	snd = Splay.ar(snd, spread);
	Out.ar(0, snd * amp);

}).add;
)


(
SynthDef(\randBeeps1, { | freq = 440 |

	var output, mod;
	~env = Env([0, 1, 0.5, 0], [0.01, 0.2, 0.1]);
	output = SinOsc.ar(freq) * SinOsc.ar(100, 0.0, 0.5, 1);
	output = output * 0.1;
	output = output * EnvGen.ar(~env, doneAction: 2);
	Out.ar(0, output);

}).add;
)


(
SynthDef(\randBeeps2, { | freq = 440 |

	var output, mod;
	~env = Env([0, 1, 0.5, 0], [0.01, 0.2, 0.1]);
	output = SinOsc.ar(freq) * SinOsc.ar(111, 0.0, 0.5, 1);
	output = output * 0.1;
	output = output * EnvGen.ar(~env , doneAction: 2);
	Out.ar(1, output);

}).add;
)



(
{
 	inf.do{
 		Synth(\bass, [
			\modFreq, rrand(100, 666),
			\modFreq2, rrand(20, 100),
			\freq, rrand(40, 100)
		]);
		rrand(1.0, 2.0).wait;
	}
}.fork;
)

(
{
 	inf.do{
 		Synth(\bass2, [
			\modFreq, rrand(100, 166),
			\modFreq2, rrand(20, 100),
			\freq, rrand(40, 60)
		]);
		rrand(0.8, 1.7).wait;
	}
}.fork;
)

(
{
 	inf.do{
 		Synth(\randBeeps1, [
			\freq, rrand(600, 1100)
		]);
		rrand(0.1, 0.3).wait;
	}
}.fork;
)

(
{
 	inf.do{
 		Synth(\randBeeps2, [
			\freq, rrand(500, 1000)
		]);
		rrand(0.1, 0.2).wait;
	}
}.fork;
)



Synth(\guitarSynth);


Synth(\fibo);




Synth(\bass2);
