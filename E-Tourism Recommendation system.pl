offerMean(offer(dahab,[diving, snorkeling, horseRiding], 10000, 2020-02-12, 2020-03-12, period(2020-03-15, 2020-04-15), 10, 5), bus).
offerMean(offer(taba,[diving], 1000, 2020-02-12, 2020-03-12, period(2020-06-01, 2020-08-31), 10, 1), bus).
offerAccommodation(offer(dahab,[diving, snorkeling, horseRiding], 10000, 2020-02-12, 2020-03-12, period(2020-03-15, 2020-04-15), 10, 5), hotel).
offerAccommodation(offer(taba,[diving], 1000, 2020-02-12, 2020-03-12, period(2020-06-01, 2020-08-31), 10, 1), cabin).

customerPreferredActivity(customer(ahmed, aly, 1993-01-30, single, 0, student), diving, 100). 
customerPreferredActivity(customer(ahmed, aly, 1993-01-30, single, 0, student), snorkeling, 100). 
customerPreferredActivity(customer(ahmed, aly, 1993-01-30, single, 0, student), horseRiding, 20).

%customerPreferredActivity(customer(engy, khaled, 1993-01-30, single, 0, student), diving, 80).
%customerPreferredActivity(customer(engy, khaled, 1993-01-30, single, 0, student), snorkeling, 70).
%customerPreferredActivity(customer(engy, khaled, 1993-01-30, single, 0, student), horseRiding, 40).


customerPreferredActivity(customer(mohamed, elkasad, 1999-01-30, single, 0, student), snorkeling, 60). 
customerPreferredActivity(customer(mohamed, elkasad, 1999-01-30, single, 0, student), diving, 20). 
customerPreferredActivity(customer(mohamed, elkasad, 1999-01-30, single, 0, student), horseRiding, 50). 
 

customerPreferredMean(customer(ahmed, aly, 1993-01-30, single, 0, student), bus, 100). 
customerPreferredMean(customer(mohamed, elkasad, 1999-01-30, single, 0, student), bus, 10).
%customerPreferredMean(customer(engy, khaled, 1993-01-30, single, 0, student), bus, 80).


customerPreferredAccommodation(customer(ahmed, aly, 1993-01-30, single, 0, student), hotel, 20). 
customerPreferredAccommodation(customer(ahmed, aly, 1993-01-30, single, 0, student), cabin, 50). 

customerPreferredAccommodation(customer(mohamed, elkasad, 1999-01-30, single, 0, student), hotel, 100). 
customerPreferredAccommodation(customer(mohamed, elkasad, 1999-01-30, single, 0, student), cabin, 79).

%customerPreferredAccommodation(customer(engy, khaled, 1993-01-30, single, 0, student), hotel, 80). 
%customerPreferredAccommodation(customer(engy, khaled, 1993-01-30, single, 0, student), cabin, 70).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

possibleSubset(L,R):-subset1(L,R1),perm(R1,R).

subset1([],[]).
subset1([H|T],[H|R1]):-subset1(T,R1).
subset1([_|T],R1):-subset1(T,R1).


perm([],[]).
perm([H|T],R):-perm(T,R1),insert1(H,R1,R).
insert1(X,[],[X]).
insert1(X,[H|T],[X,H|T]).
insert1(X,[H|T],[H|R]):-insert1(X,T,R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

choosePreferences(L,P):-
\+member(activity(A),L),possibleSubset(L,P).
choosePreferences(L,P):-
member(activity(A),L),subset2(A,S),remove(activity(A),L,L2),subset1([activity(S)|L2],P).


remove(X,[],[]).
remove(X,[X|R],R2):- remove(X,R,R2).
remove(X,[F|R],[F|S]) :-
X\==F,
remove(X,R,S).

subactivity(activity(A),activity(R1)):- 
subset2(A,R1).

subset2([H|T],[H]).
subset2([H|T],[H|R1]):-subset2(T,R1).
subset2([_|T],R1):-subset2(T,R1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

overlapPeriod(period(YYYY-MM-DD,LLLL-KK-JJ),period(AAAA-BB-CC,EEEE-QQ-II)):- 
later(AAAA-BB-CC,YYYY-MM-DD),later(LLLL-KK-JJ,AAAA-BB-CC).
%case2
overlapPeriod(period(YYYY-MM-DD,LLLL-KK-JJ),period(AAAA-BB-CC,EEEE-QQ-II)):- 
later(YYYY-MM-DD,AAAA-BB-CC),later(EEEE-QQ-II,YYYY-MM-DD).
%case3
overlapPeriod(period(YYYY-MM-DD,LLLL-KK-JJ),period(AAAA-BB-CC,EEEE-QQ-II)):- 
later(YYYY-MM-DD,AAAA-BB-CC),later(EEEE-QQ-II,LLLL-KK-JJ).
%case4
overlapPeriod(period(YYYY-MM-DD,LLLL-KK-JJ),period(AAAA-BB-CC,EEEE-QQ-II)):-
later(AAAA-BB-CC,YYYY-MM-DD),later(LLLL-KK-JJ,EEEE-QQ-II).

later(YYYY-MM-DD,AAAA-BB-JJ):-
YYYY\=AAAA,YYYY>AAAA.
later(YYYY-MM-DD,YYYY-BB-JJ):-
MM\=BB,MM>BB.
later(YYYY-MM-DD,YYYY-MM-JJ):-
DD\=JJ,DD>JJ.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getOffer([],O):-
offerMean(offer(X,A,B,C,D,E,F,G),_),
O=offer(X,A,B,C,D,E,F,G).


getOffer(L,O):-
periodOffers(L,O),
destinationOffers(L,O),
budgetOffers(L,O),
meansOffers(L,O),
accommodationOffers(L,O),
activityOffers(L,O).

destinationOffers(L,O):-
\+member(dest(D),L).

destinationOffers(L,O):- 
member(dest(X),L),
offerMean(offer(X,A,B,C,D,E,F,G),_),
O = offer(X,A,B,C,D,E,F,G).


accommodationOffers(L,O):-
\+member(accommodation(T),L).

accommodationOffers(L,O):- 
member(accommodation(T),L),
offerAccommodation(offer(X,A,B,C,D,E,F,G),T),
O = offer(X,A,B,C,D,E,F,G).

periodOffers(L,O):-
\+member(period(YYYY-MM-DD,AAAA-KK-JJ),L).

periodOffers(L,O):-
member(period(YYYY-MM-DD,AAAA-KK-JJ),L),
offerMean(offer(X,A,B,C,D,period(XXXX-NN-WW,SSSS-LL-PP),F,G),_),
overlapPeriod(period(XXXX-NN-WW,SSSS-LL-PP),period(YYYY-MM-DD,AAAA-KK-JJ)),
O = offer(X,A,B,C,D,period(XXXX-NN-WW,SSSS-LL-PP),F,G).

budgetOffers(L,O):-
\+member(budget(B),L).

budgetOffers(L,O):-
member(budget(B),L),
offerMean(offer(X,A,B1,C,D,E,F,G),_),
B>=B1,
O = offer(X,A,B1,C,D,E,F,G).

meansOffers(L,O):-
\+member(means(M),L).

meansOffers(L,O):-
member(means(M),L),
offerMean(offer(X,A,B,C,D,E,F,G),M),
O=offer(X,A,B,C,D,E,F,G).

activityOffers(L,O):-
\+member(activity(A),L).

activityOffers(L,O):-
member(activity(A),L),
subset2(A,S),
offerMean(offer(X,U,B,C,D,E,F,G),_),
subset2(U,S),
O=offer(X,U,B,C,D,E,F,G).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

accommodationSatisfaction(O,C,L,S):-
\+member(accommodation(X),L),
S = 0.

accommodationSatisfaction(O,C,L,S):-
member(accommodation(X),L),
offerAccommodation(O,X),
customerPreferredAccommodation(C,X,S).

accommodationSatisfaction(O,C,L,S):-
member(accommodation(X),L),
offerAccommodation(O,T),
T\=X,
S=0.

activityhelper(C,[],L,0).

activityhelper(C,[H|T],L,S):-
\+member(H,L),
activityhelper(C,T,L,S).

activityhelper(C,[H|T],L,S):-
member(H,L),
customerPreferredActivity(C,H,S1),
activityhelper(C,T,L,S2),
S is S1+S2.

activitySatisfaction(O,C,L,S):-
\+member(activity([X|T]),L),
S=0.

activitySatisfaction(O,C,L,S):-
member(activity(X),L),
O = offer(_,U,_,_,_,_,_,_),
activityhelper(C,X,U,S).


meanSatisfaction(O,C,L,S):-
\+member(mean(X),L),
S=0.

meanSatisfaction(O,C,L,S):-
member(mean(X),L),
offerMean(O,X),
customerPreferredMean(C,X,S).


preferenceSatisfaction(O,C,L,S):-
accommodationSatisfaction(O,C,L,S1),
activitySatisfaction(O,C,L,S2),
meanSatisfaction(O,C,L,S3),
S is S1 + S2 + S3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

recommendOfferForCustomer([],[],O):-
offerMean(offer(X,A,B,C,D,E,F,G),_),
O = offer(X,A,B,C,D,E,F,G).

recommendOfferForCustomer(Prefs, ChosenPrefs,O):-
choosePreferences(Prefs,ChosenPrefs),
getOffer(ChosenPrefs,O).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% treturn list of numbers.
highestPriority(Offer,[],[],[]).

highestPriority(Offer,[H|T],[H1|T1],[S|R]):-
preferenceSatisfaction(Offer,H,H1,S),
highestPriority(Offer,T,T1,R).

help([],_,[]).
help(_,0,[]).
help([H|T],X,[H|R]):-
X>0,
X1 is X-1,
help(T,X1,R).


%%%%%%%%%%%%%%%%%%%%%%

recommendOffer([H|T],[H1|T1], Offer, CustomersChosen):-
offerMean(offer(X,A,B,C,D,E,F,G),_),
Offer = offer(X,A,B,C,D,E,F,G),
highestPriority(Offer,[H|T],[H1|T1],S),
insert_sort2(S,[H|T],Sorted,SLC),
reverse1(SLC,R),
help(R,G,CustomersChosen).
%%%%%%%


insert_sort2(List,LC,Sorted,SLC):- 
i_sort2(List,LC,[],[],Sorted,SLC).
i_sort2([],[],Acc,Acc1,Acc,Acc1).
i_sort2([H|T],[H1|T1],Acc,Acc1,Sorted,SLC):- 
insert2(H,H1,Acc,Acc1,NAcc,NAcc1),
i_sort2(T,T1,NAcc,NAcc1,Sorted,SLC).
 
insert2(X,X1,[],[],[X],[X1]). 
insert2(X,X1,[Y|T],[Y1|T1],[Y|NT],[Y1|NT1]):- 
X>Y,insert2(X,X1,T,T1,NT,NT1).
insert2(X,X1,[Y|T],[Y1|T1],[X,Y|T],[X1,Y1|T1]):- 
X=<Y.

%%%%%%%%%


reverse1(H,R):- 
reverse2(H,[],R).
reverse2([],I,I). 
reverse2([H|T],I,R):- 
reverse2(T,[H|I],R). 

%%%%%%%%%

getPreferredActivity([],C,[]).
getPreferredActivity([H|T],C,[S|R]):-
customerPreferredActivity(C,H,S),
getPreferredActivity(T,C,R). 

getAllActivities(L):-
setof(X,Y^Z^customerPreferredActivity(Y,X,Z),L).


getHead([H|T],H).

mostPreferredActivity(C,A):-
getAllActivities(L),
getPreferredActivity(L,C,S),
insert_sort2(S,L,T,D),
reverse1(T,E),
getHead(E,U),
customerPreferredActivity(C,A,U).




max2([H],H).
max2([H,H1|T],X):-
maximum2(H,H1,X1),
max2([X1|T],X).


maximum2(A,B,C):-
B>A,
C=B.
maximum2(A,B,C):-
A>=B,
C=A.























