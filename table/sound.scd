 s.waitForBoot{
(




~osc = NetAddr.new("127.0.0.1", 1507);

(
SynthDef(\RecordPlayer, { arg bufnum = 0;
    var signal;
	signal = In.ar(0,2);
	RecordBuf.ar(signal, bufnum,recLevel: 1,preLevel: 0,loop: 0);
}).add;
);



//buffer players
(
SynthDef(\playback_rewind, { arg out, bufnum, amp, startpos = 0;
    var signal;
	signal = PlayBuf.ar(2,bufnum,Sweep.ar(out,-0.5),1,startpos,0,2) * amp;
    Out.ar(out, signal!2);
}).add
);

(
SynthDef(\playback_buf, { arg out, bufnum, amp, rate = 1, startpos = 0;
    var signal;
	signal = PlayBuf.ar(2,bufnum,rate,1,startpos,0,2) * amp;
	DetectSilence.ar(signal,0.1, 0.5,2);
    Out.ar(out, signal!2);
}).add


);
//~b1
//Synth(\playback_buf, [\bufnum, ~b1, \amp, 1 ]);
	//Pbindef(\buffer, \bufnum, ~b1,\amp,Pseq(~list1_1));

Pdef(\buffer,Pbind(\type, \note,\dur, 0.5,\instrument, \playback_buf));
Pdef(\buffer2,Pbind(\type, \note,\dur, 0.5,\instrument, \playback_buf));
Pdef(\buffer3,Pbind(\type, \note,\dur, 0.5,\instrument, \playback_buf));


////////////////////////////////////////////////////////////////////////


(~listmaker = {(


~list4_3 = {var count = 0;
	Array.fill(6138,{arg i; if(count == 5, {count = 0; i = 1},{count = count + 1;i = 0})})
	}.value;


~list3 = [0, 1, 2, 3].dup(5).allTuples;

~list3meta = ~list3.collect { |row|
	var counts = Array.fill(4, 0), metacounts = Array.fill(6, 0),
	suffixes = Array.fill(6, { Array.new }), suffixIndex;
	row.do { |val|
		counts[val] = counts[val] + 1;
	};
	counts.do { |val|
		metacounts[val] = metacounts[val] + 1;
	};
	Array.fill(5, { |i|
		var count = counts[row[i]];
		if(metacounts[count] > 1) {
			suffixIndex = suffixes[count].indexOf(row[i]);
			if(suffixIndex.isNil) {
				suffixIndex = suffixes[count].size;
				suffixes[count] = suffixes[count].add(row[i]);
			};
			count.asString + (suffixIndex + 65).asAscii
		} {
			count
		}
	})
};

);});

(
~functions1 = ({~minIndex = {arg list;var test = [], minx;
			minx = list.minItem;
			list.do{arg itm, indx; if(itm != minx, {nil},{test = test.add(indx)})};
	test.choose;};

~adder3 = {arg metaremovecount, metalistt;
	if(~comparemetalist == ~meta0, {~metaremovedlist = ~metaremovedlist.add(1);~metachooser.value(metaremovecount,metalistt)},{
				if(~comparemetalist == ~meta1, {~metaremovedlist = ~metaremovedlist.add(2);~metachooser.value(metaremovecount,metalistt)},{
					if(~comparemetalist == ~meta2, {~metaremovedlist = ~metaremovedlist.add(3);~metachooser.value(metaremovecount,metalistt)},{
						if(~comparemetalist == ~meta3, {~metaremovedlist =~metaremovedlist.add(4);~metachooser.value(metaremovecount,metalistt)},{
							if(~comparemetalist == ~meta4, {~metaremovedlist = ~metaremovedlist.add(5);~metachooser.value(metaremovecount,metalistt)},{
								if(~comparemetalist == ~meta5, {~metaremovedlist = ~metaremovedlist.add(6);~metachooser.value(metaremovecount,metalistt)}, {"errornewmeta".postln;~searchr.stop;})
					}
			)}
		)}
	)}
)}
)};



//add preference to the number that was not used in previous permutations. If there are no options use whatever
~minIndexplus = {arg list;var test = [], minx, test2;
			minx = list.minItem;
			list.do{arg itm, indx; if(itm != minx, {nil},{test = test.add(indx)})};
	test2 = test.sect(~numbrlist);
	if(test2.size == 0, {test.choose},{test2.choose});
	};

~metaremovecount3 = {arg metalistt;
	if(~metacount[0] == 240, {metalistt.remove(~meta0);"metapattern 2,1,1,1 removed"},{nil});
	if(~metacount[1] == 360, {metalistt.remove(~meta1);"metapattern 2,2,1 removed"},{nil});
	if(~metacount[2] == 240, {metalistt.remove(~meta2);"metapattern 3,1,1 removed"},{nil});
	if(~metacount[3] == 120, {metalistt.remove(~meta3);"metapattern 3,2 removed"},{nil});
	if(~metacount[4] == 60, {metalistt.remove(~meta4);"metapattern 4,1 removed"},{nil});
	if(~metacount[5] == 4, {metalistt.remove(~meta5);"metapattern 5 removed"},{nil});
};



~rpermutation = [];
~newpermutation = [nil,nil,nil,nil,nil];
~contrastlist = [];

(
~zero = 0;
~one = 0;
~two = 0;
~three = 0;
);

(
~meta0 = [1,1,1,2];
~meta1 = [0,1,2,2];
~meta2 = [0,1,1,3];
~meta3 = [0,0,2,3];
~meta4 = [0,0,1,4];
~meta5 = [0,0,0,5];
~metaremovedlist = [];
~metacount = [0,0,0,0,0,0]
);


//instruments as rows and indexes as columns
~metachart = Array2D.fromArray(5,5,Array.fill(100,0));
~instancechart3 = Array2D.fromArray(4,5,Array.fill(100,0));
~instancechart2 = Array2D.fromArray(3,5,Array.fill(100,0));
~instancechart1 = Array2D.fromArray(2,5,Array.fill(100,0));


~metachooser = {arg metaremovecount, metalist; var list2, list1 = [];

	//recover the list //removes metapattern from the selection when all permutations of this type are exhausted
	if(~metaremovedlist.size == metalist.size, {~metaremovedlist = []; metaremovecount.value(metalist)},{nil});
	~metaremovedlist.postln;

	//creates a list according to the current metalist so only the active metapatterns are counted
	list2 = Array.fill(metalist.size,{arg i; i = 0});

	~metaremovedlist.do({arg item, i; if(item > metalist.size, {nil},{list2.put(item - 1, -999999)})});
	metalist.do({arg item, i;var list = []; ~metaremovedlist.do({arg itemc, ic;
			list2.put(i,list2[i]+((abs((i+1) - itemc))));
		//list2.postln;
	});
		//"round passed".postln;
	});
		//list2.postln;
		//list2.do({arg item, i; if(item > list2.minItem, {list1 = list1.add(i)},{nil}) });
	if(metalist.size != 6, {metalist[list2.maxIndex]},{
		if(~metaremovedlist.size == 2, {if((abs(~metaremovedlist[0] - ~metaremovedlist[1]) != 3),{metalist[((~metaremovedlist[0] + ~metaremovedlist[1]) /2) - 1]},{metalist[list2.maxIndex]})},{metalist[list2.maxIndex]})
	})
	}
}));

(
~search = {arg mainlist, mainmetalist, set,metalist, metaremovecount, adder,instancechart;
~searchr = Routine({var sizeofthelist;

		sizeofthelist = mainlist.size;




		~metalist2 = metalist.deepCopy;
		~numbrlist = set.deepCopy;
	//remove the chosen permutation from the list and listmeta
~number = (mainlist.size).rand;
~rpermutation = mainlist.removeAt(~number);
mainmetalist.removeAt(~number);


//add to the full list
~contrastlist = ~contrastlist.add(~rpermutation);


"picked permutation:".postln;
~rpermutation.postln;


//add how many instances of a number at certain index
~rpermutation.do({arg item, i; instancechart.put(item,i,instancechart.at(item, i) + 1)});


//add how many instances of a number are in the permutations to the variables

~rpermutation.do({arg item, i; if(item == 0,{~zero = ~zero + 1},
	{if(item == 1, {~one = ~one + 1}, {
		if(item == 2, {~two = ~two + 1}, {
			if(item == 3, {~three = ~three + 1}, {nil})
		})
	})}
)});


//	("zero: "++~zero).postln;
	//("one: "++~one).postln;
	//("two: "++~two).postln;
	//("three: "++~three).postln;


~metafill = ~rpermutation.deepCopy;

//replaces numbers with how many instances of that number there is

~metafill.do({arg item, i; if(item == 0,{~metafill.put(i,~zero)},{
	if(item == 1,{~metafill.put(i,~one)},{
		if(item == 2,{~metafill.put(i,~two)},{
			if(item == 3,{~metafill.put(i,~three)},{"errorlol".postln})
		})
	})
})});

//"meta permutation:".postln;
//~metafill.postln;

//updates that information into the 2D array
~metafill.do({arg item, i; ~metachart.put(item - 1, i ,~metachart.at(item - 1, i) + 1)});

//sorts the meta pattern
		~comparemetalist = [~zero,~one,~two,~three].sort;

"meta pattern: ".postln;
~comparemetalist.postln;

		//add to the count of how many times this metapattern was used (extra for the first random selection)
~metalist2.do({arg item, i; if(item == ~comparemetalist, {~metacount[i] = ~metacount[i] + 1},{nil})});

//removes used meta pattern from the list and returns the one to be used
		~newmeta =  adder.value(metaremovecount,metalist);


"new meta pattern:".postln;
~newmeta.postln;

//add to the count of how many times this metapattern was used
~metalist2.do({arg item, i; if(item == ~newmeta, {~metacount[i] = ~metacount[i] + 1},{nil})});

//"meta pattern list:".postln	;
//~metalist.postln;
//~instancechart.postln;
//~metachart.postln;

while({mainlist.size > 0},{

		//to avoid error at the beginning newpermutation[nil,nil,nil]
			if(~newpermutation[0] == nil, {
				~numbrlist = if(~numbrlist.difference(((~rpermutation.as(Set)).as(Array))) == [],
	{~numbrlist = set.difference(((~rpermutation.as(Set)).as(Array)))},
	{~numbrlist = ~numbrlist.difference(((~rpermutation.as(Set)).as(Array)))});


			},{
	//remove used numbers from the previous permutation from the list if there wont be any numbers left fill the list again
	~numbrlist = if(~numbrlist.difference(((~newpermutation.as(Set)).as(Array))) == [],
	{~numbrlist = set.difference(((~newpermutation.as(Set)).as(Array)))},
	{~numbrlist = ~numbrlist.difference(((~newpermutation.as(Set)).as(Array)))});
		});

	//~numbrlist.postln;
	~newpermutation = [nil,nil,nil,nil,nil];

		~sort = {var pass = nil, indexinstance,indexlist = [[],[],[],[]], distancelist = [9999,9999,9999,9999], numberlist = [9999,9999,9999,9999],  newpermutation, distancelist2 = [9999,9999,9999,9999], numberlist2 = [9999,9999,9999,9999],instancelistcopy2, indexinstance2,first_run, metapermutation = [nil,nil,nil,nil,nil],duplicate2 = [0,0,0,0],oldminx = [0,0,0,0], occurrencelist = [] ;

		indexinstance = Array.fill(4,{arg i; i = Array.fill(4,{arg ic; ic = 0})});

		//~instancechart.postln;
		//~metachart.postln;
		//("indexinstance:" +indexinstance).postln;
		//("indexlist:" +indexlist).postln;

		~newmeta.do({arg item, i; var list = [], count = 0, duplicate;


		if(item == 0, {nil},{

		~metachart.colsDo({arg itemc, ic; list = list.insert(ic,(~metachart.at(item - 1,ic)))});
		duplicate = list.deepCopy;
		duplicate2 = duplicate2.put(i,list.deepCopy);
		//("duplicate"+duplicate).postln;
		//duplicate2.postln;

		//~newpermutation.do({arg itemc ,ic; if(itemc != nil,{duplicate.put(ic,999999999)},{nil})});
		//indexlist[i - 1].do({arg itemc ,ic; duplicate.put(itemc, 999999999)});
					indexlist.do({arg itemc ,ic;
						indexlist[ic].do({arg itemx, ix;
						duplicate.put(itemx, 999999999)});
						});

		//("duplicate"+duplicate).postln;
		//inserts as many indexes needed for the metapattern
		while({count != item},{var minindex;
		minindex = ~minIndex.value(duplicate);

		oldminx[i] = oldminx[i] + duplicate.minItem;
		indexlist[i] = indexlist[i].insert(count,minindex);
		duplicate.put(minindex,9999999);
		count = count + 1;
		});

		//puts occurences of the number into correct indexes of permutation
		indexlist[i].do({arg itemc, ic;
				metapermutation.put(itemc,item)
		});

		if(~newmeta.occurrencesOf(item) == 1, {},{

				occurrencelist = occurrencelist.add(i);
		});


		})
			});

		///////////////////////////////////////////
		//adding letters to metapermutation

		//metapermutation.postln;

		if(((~newmeta == [0,1,2,2]) || (~newmeta == [1,1,1,2]) || (~newmeta == [0,1,1,3])) == false , {},{ var  list2 = [], varr, indexnumber = [], bool;


		list2 = occurrencelist.collect({arg item, i; indexlist[item] });

		//list2.postln;

		varr = (list2.flatten).minItem;

	(indexlist.do({arg item, i; if(item.includes(varr),{indexnumber = indexnumber.add(i); },{nil}) }));


		(list2.do({arg item, i; if(item.includes(varr),{list2.remove(item)},{nil}) }));

		varr = (list2.flatten).minItem;

		(indexlist.do({arg item, i; if(item.includes(varr),{indexnumber = indexnumber.add(i) },{nil}) }));



		if(list2.size == 1, {nil},{

			(list2.do({arg item, i; if(item.includes(varr),{list2.remove(item)},{nil}) }));

			varr = (list2.flatten).minItem;

			(indexlist.do({arg item, i; if(item.includes(varr),{indexnumber = indexnumber.add(i) },{nil}) }));

		bool = true

		});

	//indexnumber.postln;
	//~indexlist.postln;
	//metapermutation.postln;

		indexlist[indexnumber[0]].do({arg itemc, ic;
			metapermutation.put(itemc, metapermutation.at(itemc) + "A")
		});

		indexlist[indexnumber[1]].do({arg itemc, ic;
			metapermutation.put(itemc,metapermutation.at(itemc) + "B")
		});

	if(bool != true, {nil},{
		indexlist[indexnumber[2]].do({arg itemc, ic;
					metapermutation.put(itemc, metapermutation.at(itemc) + "C")

		})
			})
	});

		///////////////////////////////////////////

	//indexlist.postln;
	metapermutation.postln;
			/////////////////////////////////////////////////////////////
			//check if this meta pattern is exhausted
				if(mainmetalist.detect({arg item, i; item == metapermutation}) == nil,
				{var list, totaldistancelist = [],lastlist;

				//("metapermutation not in list" + metapermutation).postln;


				//get only metapermutations of the used metapattern problem maybs
				lastlist = (mainmetalist.select({arg itema, ia;
							(itema.as(Set)).as(Array).sort == (metapermutation.as(Set)).as(Array).sort })).deepCopy;

				//calculated total distance of each metapermutation from the repeated metapermutation
				lastlist.do({arg item, i; var count;
									count = 0;
									~newmeta.do({arg itema, ia;
										if(itema == 0, {nil},{var min = 0;

								//("lastlist" + item).postln;
								//("duplicate2" + duplicate2).postln;
								item.do({arg itemb, ib;
									if(itemb == itema, {min = min + duplicate2[ia][ib]},{nil})
								});
								//("min"+ min).postln;
								//("oldminx"+ oldminx).postln;
								count = count + (min - oldminx[ia]);

										})
									});
									totaldistancelist = totaldistancelist.insert(i,count);
								});

								//lastlist.postln;

								//totaldistancelist.postln;

								if(lastlist.size == 0, {
									"lastlist is empty".postln;
									~searchr.stop;
								},{var num;
									//"compromise metapermutation".postln;
									metapermutation = (lastlist[(~minIndex.value(totaldistancelist))]).deepCopy;

									//metapermutation.postln;

						metapermutation.postln;

						num = mainmetalist.detectIndex({arg itemd, id; itemd == metapermutation});
						mainmetalist = mainmetalist.reject { |itemd, id| id == num };

						indexlist = [[],[],[],[]];

						//putting numbers from the metapermutation into the indexlist
						{var lettercount = 0;
						~newmeta.do({arg itemd, id; var count = 0, index, list = ["A","B","C"];
							if(itemd == 0, {nil},{

							if(~newmeta.occurrencesOf(itemd) > 1, {

								while({count != itemd},{

								index = metapermutation.detectIndex({ arg itemb, ib; itemd + list[lettercount] == itemb });
								indexlist[id] = indexlist[id].insert(count,index);
								metapermutation.put(index,9999999);
								count = count + 1;
							});
							lettercount = lettercount + 1;

									},{

							while({count != itemd},{

								index = metapermutation.detectIndex({ arg itemb, ib; itemd == itemb });
								indexlist[id] = indexlist[id].insert(count,index);
								metapermutation.put(index,9999999);
								count = count + 1;
							})
									}
							)
						})
								});
									}.value;


					})

			},{var num;
						metapermutation.postln;
						num = mainmetalist.detectIndex({arg itemd, id; itemd == metapermutation});
						mainmetalist = mainmetalist.reject { |itemd, id| id == num };
				});
//100.wait;
			//indexlist.postln;
			///////////////////////////////////////////////////////////////

		//updating meta chart
		~newmeta.do({arg item, i;
		indexlist[i].do({arg itemc, ic;
		~metachart.put(item - 1, itemc, ~metachart.at(item - 1, itemc) + 1);
		});
			});

		~newmeta.do({arg item, i; var list2 ,list3,  instance = nil;

		if(item == 0, {nil},{

		//	("indexes to be used for" + item + ":").postln;

		//indexlist[i].postln;

		list2 = Array.fill(instancechart.rows,{arg i; i = 0});

		//"passing each row in instancechart according to the picked indexes to look for the lowest number of instances in said index".postln;
		//each meta number has its own instance chart to avoid picking the same numbers .interpret .......decided not to. Numbers would not be different enough.
		instancechart.rowsDo({arg itemrow, irow;
				//("passing a row: " + irow).postln;
				indexlist[i].do({arg itemc, ic;
				list2[irow] = list2[irow] + instancechart.at(irow,itemc);
				indexinstance[i][irow] = indexinstance[i][irow] + instancechart.at(irow,itemc);
				//indexlist.postln;
				//list2.postln;
				//indexinstance.postln;
				})
			});

			list3 = list2.deepCopy;
			//"checking repetition".postln;
			//avoiding repetition of numbers
			while({pass != 1},{var minindex;
				//("numberlist"+~numbrlist).postln;
				minindex = ~minIndexplus.value(list3);

				//("minindex"+ minindex).postln;
				//list3.postln;

				if(~newpermutation.matchItem(minindex),{list3.put(minindex,99999)},{pass = 1; instance = minindex});
				});

				pass = nil;

			//("picked number:" + (instance) + "for number of instances:" + item).postln;

			//putting numbers into newpermutation
			indexlist[i].do({arg itemc, ic;
				~newpermutation.put(itemc, instance)
			});




			});
			});


		//copy for the trying of all the combinations second phase
		instancelistcopy2 = indexinstance.deepCopy;
		indexinstance2 = indexinstance.deepCopy;

		// remove options to repeat numbers
		~newmeta.do({arg item, i;
			if(item == 0, {nil},{
				~newmeta.do({arg itemc, ic;
					if(itemc == 0, {nil},{
						indexinstance[i] = indexinstance[i].put(~newpermutation[indexlist[ic][0]],9999)
					})

				});
			})
		});

			//("indexlist: "+ indexlist).postln;
			//("indexinstance:"+indexinstance).postln;
			//("indexinstance2:"+indexinstance2).postln;



			//("distancelist:" + distancelist).postln;
			//("numberlist:" + numberlist).postln;

					if(mainlist.detect({arg item, i; item == ~newpermutation}) == nil,
				{var list, lastlist, totaldistancelist = [];

					("repeated permutation:" + ~newpermutation).postln;


////////////////////////////////////////////////// second phase
								//all possible changes of numbers from the repeated permutation and its union of the remaining in the list of all permutations and iterate over them.
								//instancelistcopy2.postln;
								//indexinstance2.postln;
								//indexlist.postln;



								list = {var indlist = [], firstnumber, max, listt;

									max = ((~newpermutation.as(Set)).as(Array)).deepCopy;

									~newpermutation.do({arg itemx, ix; if(itemx == max[0], {indlist = indlist.add(ix)},{})});

									set.do({arg itemb, ib; var list1, indlist2 = [];
									max = ((~newpermutation.as(Set)).as(Array)).deepCopy;
										//"level-one".postln;
										firstnumber = (~newpermutation.deepCopy).put(indlist,itemb);
										//firstnumber.postln;
										if(max.size <= 1, {listt = listt.add(firstnumber.deepCopy)},{
											max.removeAt(0);

											~newpermutation.do({arg itemx, ix; if(itemx == max[0], {indlist2 = indlist2.add(ix)},{})});
												//"level-two".postln;
												list1 = set.deepCopy;
												list1.remove(itemb);
												//indlist2.postln;
												//list1.postln;
											list1.do({arg itemd, id; var firstnumber2, list2, indlist3 = [], max2;
												max2 = max.deepCopy;
												firstnumber2 =  (firstnumber.deepCopy).put(indlist2,itemd);
												//firstnumber2.postln;
												if(max2.size <= 1, {
													//firstnumber2.postln;
													listt =  listt.add(firstnumber2.deepCopy)},{

													max2.removeAt(0);

													~newpermutation.do({arg itemx, ix; if(itemx == max2[0], {indlist3 = indlist3.add(ix)},{})});
													//"level-three".postln;
													list2 = list1.deepCopy;
													list2.remove(itemd);
													//indlist3.postln;
													//list2.postln;
													list2.do({arg itemc, ic; var firstnumber3, list3, indlist4 = [], max3;
														max3 = max2.deepCopy;
														firstnumber3 =  (firstnumber2.deepCopy).put(indlist3,itemc);
														if(max3.size <= 1, {
															//firstnumber3.postln;
															listt =  listt.add(firstnumber3.deepCopy)},{

													max3.removeAt(0);

													~newpermutation.do({arg itemx, ix; if(itemx == max3[0], {indlist4 = indlist4.add(ix)},{})});
													//"level-four".postln;
													list3 = list2.deepCopy;
													list3.remove(itemc);
													//indlist4.postln;
													//list3.postln;
													list3.do({arg iteme, ie; var firstnumber4, max4;
														max4 = max3.deepCopy;
														firstnumber4 =  (firstnumber3.deepCopy).put(indlist4,iteme);
														if(max4.size <= 1, {
																	//firstnumber4.postln;
																	listt =  listt.add(firstnumber4.deepCopy)},{
																	"errorthis".postln;
													})
												})
											})
										})
											})
										})
										})
									});
									listt
								}.value;


								//list.postln;
						("all possible"+(list.size)).postln;

								list.do({arg item, i; mainlist.do({arg itemb, ib; if(itemb == item,  {lastlist = lastlist.add(itemb.deepCopy)},{nil}) })});

								lastlist.do({arg item, i; var count;
									count = 0;
									~newmeta.do({arg itema, ia;
										if(itema == 0, {nil},{var oldmin, min;
											oldmin = indexinstance2[ia][~newpermutation[indexlist[ia][0]]];
											min = indexinstance2[ia][item[indexlist[ia][0]]];
											count = count + (min - oldmin);

										})
									});
									totaldistancelist = totaldistancelist.insert(i,count);
								});

								//lastlist.postln;

								//totaldistancelist.postln;

								if(lastlist.size == 0, {
									"lastlist empty".postln;
									~searchr.stop;
								},{
									//"compromise permutation".postln;
									~newpermutation = (lastlist[(~minIndex.value(totaldistancelist))]).deepCopy;

									//~newpermutation.postln;
								});
			},{nil});

//////////////////////////////////////


		("new permutation:"+~newpermutation).postln;

		//update instance chart
		~newpermutation.do({arg item, i; instancechart.put(item, i, instancechart.at(item , i) + 1)});

		//~instancechart.postln;
		//~metachart.postln;

	}.value;



//remove from the original list and check if it is not repeated

		if(mainlist.detect({arg item, i; item == ~newpermutation}) == nil,{"error".postln;~searchr.stop;},{var num; num = mainlist.detectIndex({ arg item, i; item == ~newpermutation});
				mainlist = mainlist.reject { |itemd, id| id == num };
				"removed".postln; });

//add to the full list
~contrastlist = ~contrastlist.add(~newpermutation);

if(~contrastlist.size == sizeofthelist, {"finished".postln;~pass1 = true;
				~searchr.stop}, {nil});

(
~zero = 0;
~one = 0;
~two = 0;
~three = 0;
);


//add how many instances of a number are in the permutations to the variables

~newpermutation.do({arg item, i; if(item == 0,{~zero = ~zero + 1},
	{if(item == 1, {~one = ~one + 1}, {
		if(item == 2, {~two = ~two + 1}, {
			if(item == 3, {~three = ~three + 1}, {nil})
		})
	})}
)});

	//("zero: "++~zero).postln;
	//("one: "++~one).postln;
	//("two: "++~two).postln;
	//("three: "++~three).postln;


~metafill = ~newpermutation.deepCopy;

//replaces numbers with how many instances of that number there is

~metafill.do({arg item, i; if(item == 0,{~metafill.put(i,~zero)},{
	if(item == 1,{~metafill.put(i,~one)},{
		if(item == 2,{~metafill.put(i,~two)},{
			if(item == 3,{~metafill.put(i,~three)},{"errorfill".postln})
		})
	})
})});

//"meta permutation:".postln;
//~metafill.postln;

//sorts the meta pattern
~comparemetalist = [~zero,~one,~two,~three].sort;

//"meta pattern: ".postln;
//~comparemetalist.postln;

//removes used meta pattern from the list and returns the one to be used
			~newmeta =  adder.value(metaremovecount,metalist);



//"new meta pattern:".postln	;
~newmeta.postln;

//add to the count of how many times this metapattern was used
~metalist2.do({arg item, i; if(item == ~newmeta, {~metacount[i] = ~metacount[i] + 1},{nil})});

//"meta pattern list:".postln	;
//~metalist.postln;
//~instancechart.postln;
	//~metachart.postln;


	});
}).play
});
////////////////////////////////////////////////////////////////////////




(
~routinemain = Routine({
		//mixing permutations and setting up
	s = Server.local;
	1.wait;

	////////////////////////////////////////////////
		~pass1 = false;
	~listmaker.value;
	0.1.wait;
	~functions1.value;
		0.1.wait;
	~search.value(~list3,~list3meta,[0,1,2,3],[~meta0,~meta1,~meta2,~meta3,~meta4, ~meta5],~metaremovecount3,~adder3,~instancechart3,~contrastlist3);
	0.1.wait;
	while({~pass1 == false}, {1.wait;
		"waiting".postln;
	});
	~pass1 = false;
		~contrastlist3 = ~contrastlist;
	0.1.wait;
	~list1_3 = ~contrastlist3.collect({arg item, i; item.collect({arg itemx, ix; if(itemx == 1, {1},{0})})  });
	~list2_3 = ~contrastlist3.collect({arg item, i; item.collect({arg itemx, ix; if(itemx == 2, {1},{0})})  });
	~list3_3 = ~contrastlist3.collect({arg item, i; item.collect({arg itemx, ix; if(itemx == 3, {1},{0})})  });
	//~list1_3 = ~contrastlist3.collect({arg item, i; item.collect({arg itemx, ix; if(itemx == 1, {1},{0})}) ++ 0 });
	//~list1_3 = ~list1_3.flatten;
	//~list2_3 = ~contrastlist3.collect({arg item, i; item.collect({arg itemx, ix; if(itemx == 2, {1},{0})}) ++ 0 });
	//~list2_3 = ~list2_3.flatten;
	//~list3_3 = ~contrastlist3.collect({arg item, i; item.collect({arg itemx, ix; if(itemx == 3, {1},{0})}) ++ 0 });
	//~list3_3 = ~list3_3.flatten;
	////////////////////////////////////////////////

	0.1.wait;

	//sub routines
	(
		~routine3 = Routine({
			var count = 0, nodeIDs, cond = Condition({ nodeIDs.size == 0 });
			while ({(count + 1) < ~contrastlist3.size},{
				~contrastlist[count].postln;
				~osc.sendMsg("/values", (~contrastlist[count]).asString, ~contrastlist3.size - count );
				//{b.string_((~contrastlist[count]).asString }.defer;
				//{a.string_(~contrastlist3.size - count)}.defer;
				Spawner({| sp |
					sp.seq(Ppar([
						Pbindef(\buffer, \bufnum, ~b1,\amp,Pseq(~list1_3[count]), \callback,{ |ev|
							ev[\id].do { |id|
								nodeIDs = nodeIDs.add(id);
								OSCFunc({
									nodeIDs.remove(id);
									// unblock the routine when condition is met
									cond.signal;
								}, '/n_end', argTemplate: [id]).oneShot;
							};
						}),
						Pbindef(\buffer2, \bufnum, ~b2,\amp,Pseq(~list2_3[count]),\callback,{ |ev|
							ev[\id].do { |id|
								nodeIDs = nodeIDs.add(id);
								OSCFunc({
									nodeIDs.remove(id);
									// unblock the routine when condition is met
									cond.signal;
								}, '/n_end', argTemplate: [id]).oneShot;
							};
						}),
						Pbindef(\buffer3, \bufnum, ~b3,\amp,Pseq(~list3_3[count]),\callback,{ |ev|
							ev[\id].do { |id|
								nodeIDs = nodeIDs.add(id);
								OSCFunc({
									nodeIDs.remove(id);
									// unblock the routine when condition is met
									cond.signal;
								}, '/n_end', argTemplate: [id]).oneShot;
							};
						})
					]));
				}).play;
				cond.hang;
				0.5.wait;
				count = count + 1;
			});

			//~recorder100.free;
			//~time_rewind = ~timer_rewind.beats;
			//~timer_rewind.stop;
			~routinemain.stop;
			0.1.wait;
			//~rewind_sound = Synth(\playback_rewind,[\bufnum, ~b100, \amp, 1,\startpos, s.sampleRate * ~time_rewind, ]).register;
			0.01.wait;
			"rewinding and restarting".postln;
			while ({~rewind_sound.isPlaying == true}, { 0.1.wait;});
			~routinemain.reset;
			~routinemain.play;
		})
	);


	1.wait;
	~path1 = PathName("/home/pi/Desktop/yes").entries.choose.fullPath;
	~path2 = PathName("/home/pi/Desktop/yes").entries.choose.fullPath;
	~path3 = PathName("/home/pi/Desktop/yes").entries.choose.fullPath;
	~path1.postln;
		~path2.postln;
		~path3.postln;




	~b1 = Buffer.read(s,~path1 ,bufnum: 1);
	~b2 = Buffer.read(s,~path2,bufnum: 2);
	~b3 = Buffer.read(s,~path3 ,action: {~pass1 = true},bufnum: 3);
	"now all 1023 possible permutations of three sounds within 5 seconds will be iterated".postln;
	"sound one:".postln;
		~list1_3.postln;
	"sound two:".postln;
		~list2_3.postln;
	"sound three:".postln;
		~list3_3.postln;
	"limit:".postln;
		~list4_3.postln;

	//začátek nahrávání
	//~recorder100 = Synth(\RecordPlayer,[\bufnum, ~b100]);
	~timer_rewind = TempoClock();
	while({~pass1 == false}, {1.wait;
		"waiting".postln;
	});
	~routine3.play;





});

);
);
~routinemain.play;
}
