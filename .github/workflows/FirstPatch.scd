(
Ndef(\mod, {
	var freq = MouseX.kr(400, 600);
	var snd = (SinOsc.ar(freq).distort * 0.8 * (SinOsc.kr(3) * 0.15 + 0.5)) + (SinOsc.ar(freq  - 10).distort * 0.15 * (SinOsc.kr(6) * 0.5 + 0.5)) + (SinOsc.ar(freq  + 10).distort * 0.15 * (SinOsc.kr(6) * 0.5 + 0.5));
	snd = snd * SinOsc.ar(50) * 0.2;
	snd.dup;
});
Ndef(\mod).fadeTime = 1;
Ndef(\mod).free(1);
Ndef(\mod).play;
)
Ndef(\mod).clear;
Ndef(\mod).stop;


(
Ndef(\mod2, { |freq = 70|
	var snd = SinOsc.ar(freq) * (SinOsc.kr(1) * 0.5 + 0.5);
	snd = snd * SinOsc.ar((SinOsc.kr(2.3) * 0.2)) * 1;
	FreeVerb.ar(snd, 0.5, 0.7, 0.5).dup;
});
Ndef(\mod2).play;
)

(
Ndef(\mod3, {
	var lfoFreq = MouseY.kr(1, 100);
	var snd = SinOsc.ar(280 + Saw.ar(200, 300)) * 0.2;
	snd = snd * Blip.ar(9, 0.2, 0.2);
	snd = snd * LFPar.ar(lfoFreq);
	snd.dup;
});
Ndef(\mod3).fadeTime = 0.5;
Ndef(\mod3).play;
)







