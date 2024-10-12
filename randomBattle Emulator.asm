.386
IDEAL
MODEL small
STACK 100h
DATASEG

 instructionmessage1 db 'hi, you will be presented with a screen,',13,10,'$'
 instructionmessage2 db 'you can use the 1-4 keys on your keyboard',13,10,'$'
 instructionmessage3 db 'to choose the coresponding move (form left to right)',13,10,'$'
 instructionmessage4 db 'press any key to start',13,10,'$'
 winningmessage db 'You Won',13,10,'$' ; the message saying you won
 losingmessage db 'You Lost',13,10,'$' ; the message saying you lost
playAgainMessage db 'would you like to play again? (y for yes, n for no) ',13,10,'$'
 weather dw 0; the weather at the battle field

 aRandom dw 107
 ;the number multypling each time
 cRandom dw 227
 ;the number added each time
 modRandom dw 257d
 ;the max
 numRandom dw 1d
;seed given by the user changes each time 

ex dw 0d; an variable used for repeating in doTurn

allPokemon dw offset pokemon26,offset pokemon98, offset pokemon114, offset pokemonNadav,offset pokemonRoee,offset pokemonTomer ; offfsets of all the pokeomons
numOfPokemon dw 4; how many pokemon there are
 
; The stored data about a pokemon         
struc pokemonData
	pokadexNum db ? ; teh number in the pokedex
	type1 dw ? ; pokemon first type
	type2 dw ? ; pokemon's second type
	hp dw ?  ; base HP
	attack dw ? ;base attack 
	defence dw ? ;base defence
	special dw  ? ; base speacial
	speed dw ? ;base speed
	movesPossible dw ? ; offset of the possible moves
	numOfMoves dw ? ;how many moves teh pokemon can learn

ends pokemonData

; the stored data about a move
struc move 
	movNum dw ? ; the number(instead of name)
	type dw ? ; the move type
	move_power dw ?;the moves power
	move_accuracy dw ?; the moves accuracy
	stat_lowered dw ?     ; 1 attack 2 defence 3 special 4 speed
	chance_stat_lowered dw ? ;odds of lowering a stat
	status dw ? ; 1 paralize 2 posion 3 burn 4 sleep 5 freeze 6 badlyPoisoned
	status_chance dw ? ;adds of givig status
	confusion_chance dw ?; odds of confusing
	recoil_precent dw ? ; what precent the pokemon takes as recoil
	priorety dw ?  ; the priorety of a move
	regen_precent dw ?;what precentage the user regens
	isSpecial dw ?;weather the move uses attack or special
	flinchChance dw ?;odds of the other pokemon flinch
	isSelfStatLowering dw ? ;one if 1 self 0 if opponent
ends move


;the stored data of a 
struc pokemon;ready to battle pokemon

	pokemon_name db ? ;name/number of the pokemon
	type1 dw ? ;the first type of the pokemon
	type2 dw ?; the second type of the pokemon
	hp dw ?  ; the hp stat
	attack dw ? ; the attack stat 
	defence dw ?; the defence stat
	special dw ? ; the special stat
	speed dw ? ; the speed stat 
	hpMax dw ?; the maximum hp of a pokemon
	move1 dw ?; the offset of the first move
	move2 dw ?; the offset of the second move
	move3 dw ? ; the offset of the third move
	move4 dw ? ; the offset of the fourth move
	status dw 0; the status inflicted on the pokemon
	level dw 50d; the pokemons level
	attackChange dw 7; the attack changes, 7 is nutural
	defenceChange dw 7 ; the defence changes
	specialChange dw 7 ; the special changes
	speedChange dw 7;the speed changes
	confusionCounter dw 0; the number of turns left in confusion
	lightScreen dw 0; number of turns of light screen left
	reflect dw 0; number of turns of reflect left
	poisonCounter dw 1;number of turns the pokemono is badly poisoned for

ends pokemon

playerPokemon pokemon  <1,1,1,1,1,1,1,1,1,1,1,1,1>; the player pokemon
opponentPokemon pokemon <1,1,1,1,1,1, 1,1,1,1,1,1,1>; the opponenet pokemon


; type: 1 normal
; ; 	2 fire
; 		3 water
; 		4 grass
; 		5 electric
; 		6 ice
; 		7 fighting
; 		8 poison
; 		9 ground
; 		10 flying
; 		11 psychic
; 		12 bug
; 		13 rock
; 		14 ghost 
; 		15 dragon
confusion move  <0,0,40,100d,0,0,0,0,0,0,0,0,0,0,0>
pound move 		<1,1,40,100d,0,0,0,0,0,0,0,0,0,0,0>
karateChop move <2,1,75,100d,0,0,0,0,0,0,0,0,0,0,0>
doubleSlap move <3,1,15,85d ,0,0,0,0,0,0,0,0,0,0,0>
cometPunch move <4,1,18,85d ,0,0,0,0,0,0,0,0,0,0,1>
megaPunch move  <5,1,80,85d ,0,0,0,0,0,0,0,0,0,0,0>
payDay move 	<6,1,18,85d ,0,0,0,0,0,0,0,0,0,0,0>
firePunch move 	<7,2,75,100d,0,0,3,10,0,0,0,0,0,0,0>
icePunch move 	<8,6,75,100d,0,0,5,10,0,0,0,0,0,0,0>
thunderPunch move <9,5,75,100d,0,0,1,10,0,0,0,0,0,0,0>
scratch	move	<10h,1,40,100d,0,0,0,0,0,0,0,0,0,0,0>
viseGrip move	<11h,1,55,100d,0,0,0,0,0,0,0,0,0,0,0>
guiilutine move <12h,1,10000,30,0,0,0,0,0,0,0,0,0,0,1>
razorWind move	<13h,1,80,100d,0,0,0,0,0,0,0,0,1,0,0>
swordDance move <14h,1,0,100d,0,0,0,0,0,0,0,0,0,0,1>
cut move 		<15h,1,50,95d,0,0,0,0,0,0,0,0,0,0,0>
gust move 		<16h,10,40,100d,0,0,0,0,0,0,0,0,1,0,0>
wingAttack move	<17h,10,35,100d,0,0,0,0,0,0,0,0,0,0,0>
whirlwind move 	<18h,1,0,85d,0,0,0,0,0,0,0,0,0,0,1>
fly move 		<19h,10,70,95d,0,0,0,0,0,0,0,0,0,0,1>
bind move 		<20h,1,15,70d,0,0,0,0,0,0,0,0,0,0,1>
slam move 		<21h,1,80,75d,0,0,0,0,0,0,0,0,0,0,0>
vineWhip move 	<22h,4,35,100d,0,0,0,0,0,0,0,0,0,0,0>
stomp move 		<23h,1,65,100d,0,0,0,0,0,0,0,0,0,0,0>
doubleKick move <24h,7,60,100d,0,0,0,0,0,0,0,0,0,0,0>
megaKick move 	<25h,1,120,75d,0,0,0,0,0,0,0,0,0,0,0>
jumpKick move   <26h,7,70,95d,0,0,0,0,0,0,0,0,0,0,0>
rollingKick move <27h,7,60,85d,0,0,0,0,0,0,0,0,0,0,0>
willowisp move <28h,2,0,100,0,0,3,75>
thunderWave move <29h,5,0,100,0,0,1,75>
  
ohko move <69h,0,10000,50,0,0,0,0,0,0,0,0,0,0>

moves26 dw offset cut, offset pound,offset icePunch,offset jumpKick,offset rollingKick, offset doubleKick , offset firePunch, offset whirlwind, , offset gust
moves98 dw offset gust,offset slam, offset bind,offset fly,offset cut,offset swordDance, offset pound
moves114 dw offset jumpKick, offset vineWhip, offset firePunch, offset thunderPunch,offset gust,offset slam, offset bind,offset fly,offset cut,offset swordDance, offset pound

movesNadav dw offset jumpKick, offset rollingKick, offset jumpKick, offset megaKick, offset icePunch
movesRoee dw offset firePunch, offset icePunch, offset thunderPunch,offset stomp
movesTomer dw offset willowisp,offset thunderWave


pokemon26 pokemonData    <26,5,0,60,90,55,90,100,offset moves26,8>;;;;;;;;;;;;;;;;;;;;;;;;;;
pokemon98 pokemonData    <98,3,0,30,105,90,50,25,offset moves98,7>
pokemon114 pokemonData <114,4,0,65,55,115,100,60,offset moves114,10>

; pokemonIdo pokemonData 
pokemonNadav pokemonData <2,3,2,1440,24,69,100,800,offset movesNadav,5>
pokemonRoee pokemonData  <69h,8,4,6900,69,420,4200,6942, offset movesRoee,4>
pokemonTomer pokemonData <1,1,14, 1   ,10000,1,1  ,10000, offset movesTomer,2>


pokeman pokemon  <50d,1,1d,1d,1d,1d,1d,offset pound> 

;---------------------------
; have fun from Tomer
; --------------------------
; Your variables here

; --------------------------

CODESEG
proc doEndMessage
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov dx, offset playAgainMessage
						mov ah,9
						int 21h

						waitForIt:

						mov ah, 6
						mov dl, 255
						int 21h 
						mov ah, 7
						int 21h 
						mov ah,0


						cmp ax, 'y'
						je again

						cmp ax,'n'
						je notAgain


						jmp waitForIt

						again:
						mov [bp+4],1
						jmp endingDoEndMessage

						notAgain:
						mov [bp+4],0
						jmp endingDoEndMessage

					endingDoEndMessage:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp doEndMessage

; returns the number of turns a pokemon has been poisened for

proc getPoisonCounter
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4];pokemon
						add bx,43
						mov bx,[bx]

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getPoisonCounter

; increases the poidon counter
proc incPoisonCounter
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4];pokemon
						
						push bx
							call getPoisonCounter
						pop ax
						inc ax
						add cx,43
						; mov [cx],ax 
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp incPoisonCounter

; makes a pokemon take burn damage
 proc doBurnDamage
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4];pokemon

						push ax
							call getStatus
						pop bx
						cmp bx,3
						jne continue28

						push ax 
							call getHp
						pop bx

						push ax 
							call getMaxHp
						pop cx
						
						push ax
							mov dx,0
							mov ax, cx
							mov cx,16
							div cx
							mov cx,ax
						pop ax
						; cx is 1/16 of the max hp

						cmp cx,bx
						jge burnKills
						jmp burnDoesntKill					

						burnKills:
						push 0 
							push ax
								call setHp
						jmp continue28

						burnDoesntKill:
						sub bx,cx
						push bx
							push ax
								call setHp
						jmp continue28


						continue28:
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp doBurnDamage


; makes a pokemon take poison damage
 proc doPoisonDamage
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4];pokemon

						push ax
							call getStatus
						pop bx
						cmp bx,2
						jne continue29

						push ax 
							call getHp
						pop bx

						push ax 
							call getMaxHp
						pop cx
						
						push ax
							mov dx,0
							mov ax, cx
							mov cx,16
							div cx
							mov cx,ax
						pop ax
						; cx is 1/16 of the max hp

						cmp cx,bx
						jge poisonKillls
						jmp poisonDoesntKill					

						poisonKillls:
						push 0 
							push ax
								call setHp
						jmp continue29

						poisonDoesntKill:
						sub bx,cx
						push bx
							push ax
								call setHp
						jmp continue29


						continue29:
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp doPoisonDamage

; pokemon takes increasing poison damage
 proc doBadlyPoisonDamage
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4];pokemon

						push ax
							call incPoisonCounter

						push ax
							call getStatus
						pop bx
						cmp bx,6
						jne continue30

						push ax 
							call getHp
						pop bx

						push ax 
							call getMaxHp
						pop cx
						
						push ax
							mov dx,0
							mov ax, cx
							mov cx,16
							div cx
							mov cx,ax
						pop ax
						; cx is 1/16 of the max hp

						push ax
							push ax
								call getPoisonCounter
							pop ax
							mul cx
							mov cx,ax
						pop ax 

						cmp cx,bx
						jge badlyPoisonKill
						jmp badlyPoisonDoesntKill			

						badlyPoisonKill:
						push 0 
							push ax
								call setHp
						jmp continue30

						badlyPoisonDoesntKill:
						sub bx,cx
						push bx
							push ax
								call setHp
						jmp continue30



						continue30:
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp doBadlyPoisonDamage

; returns the status a move may cause
proc getMoveStatus
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						add bx,12
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMoveStatus

; returns the chance of a move to cause a status
proc getMoveStatusChance
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						add bx,14
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMoveStatusChance


; returns the pokadex num of a pokemon
proc getPokadexNum
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					mov ax,0
						mov bx,[bp+4]
						add bx,0
						mov bx,[bx]
						mov al,bl
						mov [bp+4],ax
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getPokadexNum

; sets the pokadex num
proc setPokadexNum
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					mov ax,0
						mov ax,[bp+6];amount
						mov bx,[bp+4];position
						; sub bx,1
						mov cx,[bx]
						mov ah,ch
						mov [bx],ax
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setPokadexNum

; returns teh number of the move
proc getMoveNum
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					mov ax,0
						mov bx,[bp+4]
						add bx,0
						mov bx,[bx]
						mov [bp+4],bx
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMoveNum

; sets the move number
proc setMoveNum
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+6];amount
						mov bx,[bp+4];position
						mov [bx],ax
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setMoveNum

; calculates the effort value of a pokemon
proc calculateEvs
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					; mov bx,0
					; mov ax,32768d
					; mov cx,15
					; mov dx,0
					; evloop:
					;  	push cx
					; 		push ax
					; 			push 2
					; 				call RandomMax
					; 			pop bx
					; 			mul bx
					; 			add dx,ax
					; 			; adds either 0 or the number
					; 		pop ax
					; 		push dx
					; 			mov dx,0
					; 			mov cx,2
					; 			div cx
					; 		pop dx
						

					; 	pop cx
					; loop evloop
					mov dx,255
					push dx
					 	call RandomMax
					pop dx
					mov [bp+4],dx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateEvs


; generates individual values for a pokemon
proc calculateIv
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,16d
						push ax
							call RandomMax
						pop ax
						mov [bp+4],ax 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateiv


; sets the first type of a pokemon
proc setType1
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						mov cx,[bp+6]
						add bx,1
						;bx is the location of type1
						mov [bx],cx

					pop dx 
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setType1


; sets the second type of a pokemon
proc setType2
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						mov cx,[bp+6]
						add bx,3
						;bx is the location of type2

						mov [bx],cx


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setType2


; sets the first move of a pokemon
proc setMove1
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						mov cx,[bp+6]
						add bx,17
						;bx is the location of move1
						mov [bx],cx

					pop dx 
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setMove1

; sets the second move of a pokemon
proc setMove2
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						mov cx,[bp+6]
						add bx,19
						;bx is the location of move1
						mov [bx],cx

					pop dx 
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setMove2

; sets the third move of a pokemon
proc setMove3
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						mov cx,[bp+6]
						add bx,21
						;bx is the location of move1
						mov [bx],cx

					pop dx 
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setMove3

; sets the forth move of a pokemon
proc setMove4
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						mov cx,[bp+6]
						add bx,23
						;bx is the location of move1
						mov [bx],cx

					pop dx 
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setMove4

;calculates the hp of a pokemon
proc calculateHp
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						push bx
							call getHp
						pop ax
						push bx
							push ax
								call calculateStats
						pop bx
						add bx,5
						mov [bp+4],bx 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateHp

; calculates the speed of a pokemon
proc calculateSpeed
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						push bx
							call getSpeed
						pop ax
						push bx
							push ax
								call calculateStats
						pop bx
						mov [bp+4],bx 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateSpeed


; calculates the attack of a pokemon
proc calculateSpecial
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						push bx
							call getSpecial
						pop ax
						push bx
							push ax
								call calculateStats
						pop bx
						mov [bp+4],bx 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateSpecial


; calculates the defence of a pokemon
proc calculateDefence
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						push bx
							call getDefence
						pop ax
						push bx
							push ax
								call calculateStats
						pop bx
						mov [bp+4],bx 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateDefence


; calculates the attack stat of a pokemon
proc calculateAttack
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						push bx
							call getAttack
						pop ax
						push bx
							push ax
								call calculateStats
						pop bx
						mov [bp+4],bx 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp calculateAttack

;does the calculation for a generic stat
proc calculateStats
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4];base stats
						mov cx,[bp+6];pokemon
						
						push ax
							call calculateEvs
						pop ax
						
						push bx
							mov dx,0
							mov bx,4
							div bx
						pop bx
						; (evs*0.25)
						
						
						
						push ax
							call calculateIv
						pop dx
						add dx,dx
						;dx*2
						add dx,ax
						;  2IV + floor(0.25 x EV)
						mov ax,2
						push dx
						mul bx
						pop dx
						add ax,dx

						; push cx
						; 	call getLevel
						; pop dx
						mov dx,50d
						mul dx
; (2 x( Base + IV) + floor(0.25 x EV)) x Level) 
						mov bx ,100
						push dx
							mov dx,0		
							div bx
						pop dx
						; 0.01 x (2 x Base + IV + floor(0.25 x EV)) x Level
						
						add ax ,5
						mov [bp+6],ax

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp calculateStats

;returns how many turns of confusion are left
proc getConfusionCounter
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,37d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getConfusionCounter


; gets the amount a move regens to the user 
proc getRegenPrecent
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,22d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getRegenPrecent

; gets the recoil precent of a move 
proc getRecoil
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,18d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getRecoil

; gets the accuracy of a move 
proc getAccuracy
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,6d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getAccuracy

; gets the hp of pokemon 
proc getHp
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,5
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getHp



; sets the hp of pokemon 
proc setHp
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						mov ax, [bp+6]
						add bx,5d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setHp

; sets the max hp of pokemon 
proc setMaxHp
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						mov ax, [bp+6]
						add bx,15d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setMaxHp

; gets the max hp of pokemon 
proc getMaxHp
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,15d
						mov bx,[bx]
						mov [bp+4],bx
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 
endp getMaxHp

; sets the attack of pokemon 
proc setAttack
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] ;location
						mov ax, [bp+6];amount
						add bx,7d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setAttack

; sets the hp of pokemon 
proc setDefence
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						mov ax, [bp+6]
						add bx,9d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setDefence


; sets the special stat of pokemon 
proc setSpecial
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						mov ax, [bp+6]
						add bx,11d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setSpecial

; sets the speed of pokemon 
proc setSpeed
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						mov ax, [bp+6]
						add bx,13d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setSpeed



; gets the priorety of the move , usually 0 
proc getPriorety
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,20d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getPriorety

; gets the power of a move
proc getPower
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,4d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getPower




; gets the first type of a pokemon 
proc getType1
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,1d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getType1


; gets the first type of a pokemon 
proc getType2
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,3d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getType2


; gets the attack stat
proc getAttack
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,7d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getAttack


; gets the defence stat
proc getDefence
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,9d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getDefence



; gets the special attack stat
proc getSpecial
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,11d
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getSpecial

proc getSpeed
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 
						add bx,13d
						mov bx,[bx]
						mov [bp+4],bx
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getSpeed

; gets the actual speed stat
proc getEnhancedSpeed
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4] 

						push bx 
							call getSpeed
						pop ax

						push bx
							call getSpeedChange
						pop cx

						push ax
							push cx
								call getChagedStat
						pop ax
						;ax is the status
						push bx
							call getSpeed
						pop bx


						cmp ax,1
						jne continue16
						mov ax,bx
						mov bx,4
						push dx
							mov dx,0 
							div bx
						pop dx
						mov bx,ax
						; cuts speed in half when paralized
						continue16:
						mov [bp+4],bx
						


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getEnhancedSpeed

; gets the level of a pokemon
proc getLevel
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4]
						add bx,27d; 
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getLevel

; returns how many attack changes a pokemon had
proc getAttackChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					
						mov bx,[bp+4]
						add bx,29d
						mov bx,[bx]
						mov [bp+4],bx


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getAttackChange


; returns how many defence changes a pokemon had
proc getDefenceChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					
						mov bx,[bp+4]
						add bx,31d
						mov bx,[bx]
						mov [bp+4],bx


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getDefenceChange



; returns how many special changes a pokemon had
proc getSpecialChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					
						mov bx,[bp+4]
						add bx,33d
						mov bx,[bx]
						mov [bp+4],bx


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getSpecialChange


; returns how many speed changes a pokemon had
proc getSpeedChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
					
						mov bx,[bp+4]
						add bx,35d
						mov bx,[bx]
						mov [bp+4],bx


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getSpeedChange



; sets how many attack changes a pokemon had
proc setAttackChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+6] ;location
						mov ax, [bp+4];amount
						add bx,29d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setAttackChange


; sets how many defence changes a pokemon had
proc setDefenceChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+6] ;location
						mov ax, [bp+4];amount
						add bx,31d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setDefenceChange



; sets how many special changes a pokemon had
proc setSpecialChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+6] ;location
						mov ax, [bp+4];amount
						add bx,33d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setSpecialChange


; sets how many speed changes a pokemon had
proc setSpeedChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+6] ;location
						mov ax, [bp+4];amount
						add bx,35d
						mov [bx],ax
						

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setSpeedChange


; return the amount after changes
proc getChagedStat
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov ax,[bp+6] ;amount before
						mov bx, [bp+4];change
						mov cx,2
						mov dx,2

						cmp bx,7
						je nuturalChange
						jg positiveChange
						jl negativeChange

						positiveChange:
						sub bx,7
						add cx,bx
						jmp nuturalChange

						negativeChange:
						add dx,7
						sub dx,bx
						jmp nuturalChange

						nuturalChange:
						push ax
							mov ax,cx
							mov bx,dx

							mov dx,0
							div bx
							mov bx,ax
						pop ax

						mul bx

						mov [bp+6],ax

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp getChagedStat

; returns the changed attack stat(with stat changes)
proc getEnhancedAttack
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4]

						push ax
							call getAttack
						pop bx
						push ax
							call getAttackChange
						pop cx

						push bx
							push cx
								call getChagedStat

						pop ax
						mov [bp+4],ax


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getEnhancedAttack


; returns the changed defence stat(with stat changes)
proc getEnhancedDefence
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4]

						push ax
							call getDefence
						pop bx
						push ax
							call getDefenceChange
						pop cx

						push bx
							push cx
								call getChagedStat
								
						pop ax
						mov [bp+4],ax


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getEnhancedDefence


; returns the changed special stat(with stat changes)
proc getEnhancedSpecial
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4]

						push ax
							call getSpecial
						pop bx
						push ax
							call getSpecialChange
						pop cx

						push bx
							push cx
								call getChagedStat
								
						pop ax
						mov [bp+4],ax


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getEnhancedSpecial


; returns the status of a pokiiiimen(burn,sleep...)
proc getStatus 
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						add bx , 25;status is the forteenth item
						mov bx,[bx]
						mov	[bp+4],bx
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getStatus



; sets the status of a pokiiiimen(burn,sleep...)
proc setStatus 
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+6];the pokemon to set the status to
						mov ax,[bp+4]; the status to change to
						add bx , 25;status is the forteenth item
						mov [bx],ax
						
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setStatus



; returns weather a move is a special
proc getIsSpecial
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						add bx,24 ;is special is the thirteenth item
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getIsSpecial

; returns the odds of flinching someone
proc getFlinch
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4]
						add bx,26
						mov bx,[bx]
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getFlinch

;gets the type of a move
proc getType
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx, [bp + 4]
						add bx,2; type is the second item
						mov bx,[bx]
						mov [bp+4],bx
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getType

; returns the number of moves a pokemon has
proc  getNumOfMoves
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

					mov bx,[bp+4]

					add bx,17d;the tenth item with dw so 2*!0 =20

					mov bx,[bx];takes the item in the bx position

					mov [bp+4],bx
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getNumOfMoves

; returns the offset of the moves of a pokemon
proc getMoves
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx

						mov bx,[bp+4];bx is the offset of the pokemon data
						add bx, 15d ; the moves are the nineth item
						mov bx,[bx]
						
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMoves


; returns the offset of the first move
proc getMove1
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx


						mov bx,[bp+4];bx is the offset of the pokemon data
						add bx, 17d ; the moves are the nineth item
						mov bx,[bx]
						
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMove1


; returns the offset of the second move
proc getMove2
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx


						mov bx,[bp+4];bx is the offset of the pokemon data
						add bx, 19d ; the moves are the nineth item
						mov bx,[bx]
						
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMove2


; returns the offset of the third move

proc getMove3
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx


						mov bx,[bp+4];bx is the offset of the pokemon data
						add bx, 21d ; the moves are the nineth item
						mov bx,[bx]
						
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMove3


; returns the offset of the fourth move
proc getMove4
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx


						mov bx,[bp+4];bx is the offset of the pokemon data
						add bx, 23d ; the moves are the nineth item
						mov bx,[bx]
						
						mov [bp+4],bx

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getMove4


; returns a random move
proc getRandomMove
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						
						mov bx, [bp+4];bx is the pokemon data
						
						push bx 
							call getNumOfMoves
						pop cx
						push cx
							call RandomMax
						pop cx 
						mov ax,2
						mul cx
						;the position in the array
						
						push bx 
							call getMoves
						pop bx
						add bx, ax
						mov bx,[bx]
						

						; ax is the offset of the moves  
						; mov bx,[bx]
						; ax is the position of the move
						mov [bp+4] , bx
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp


ret 
ENDP getRandomMove


; generates pokemon randomly
proc generateBattleReadyPokemon
	push bp 
		mov bp, sp
		push ax
			push bx
				push cx 
					push dx
						mov bx, [bp+4] ; the target location
						mov cx, [bx]

						mov ax , [numOfPokemon]
						push ax
							call RandomMax
						pop ax 
						;index of the random pokemon
						; mov ax, 5

						mov cx,2 
						mul cx
						;makes the position in the array

						mov cx, offset allPokemon
						
						add ax, cx
						;location of pokemon after calculation
						
						push bx
							mov bx,ax;for some reason dose'nt work with ax
							mov ax,[bx]
							;ax is the pokemon data
						pop bx

						push ax
							call getPokadexNum
						pop cx 
						push cx
							push bx
								call setPokadexNum
						; sets type1
						push ax
							call getType1
						pop cx 
						push cx
							push bx
								call setType1

						; sets type2
						push ax
							call getType2
						pop cx 
						push cx
							push bx
								call setType2


						;sets Hp
						push ax
							call calculateHp
						pop cx 
						push cx
							push bx
								call setHp
						
						push cx
							push bx
								call setMaxHp
						
						;sets attack
						push ax
							call calculateAttack
						pop cx 
						push cx
							push bx
								call setAttack

						;sets defence
						push ax
							call calculateDefence
						pop cx 
						push cx
							push bx
								call setDefence
						
						
						;sets special
						push ax
							call calculateSpecial
						pop cx 
						push cx
							push bx
								call setSpecial
						
						;sets speed
						push ax
							call calculateSpeed
						pop cx 
						push cx
							push bx
								call setSpeed

						;sets the first move
						push ax
							call getRandomMove
						pop cx
						push cx
							push bx
								call setMove1


						;sets the second move
						push ax
							call getRandomMove
						pop cx
						push cx
							push bx
								call setMove2

						
						;sets the third move
						push ax
							call getRandomMove
						pop cx
						push cx
							push bx
								call setMove3
								
						;sets the forth move
						push ax
							call getRandomMove
						pop cx
						push cx
							push bx
								call setMove4
					pop dx
				pop cx
			pop bx 
		pop ax
	pop bp
ret 2
ENDP generateBattleReadyPokemon


; does regen
proc doRegen
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov cx, [bp+8];pokemon
						mov bx,[bp+6];move
						mov ax, [bp+4];damage
						push bx
							 call getRegenPrecent
						pop dx
						mul dx
						push cx
							mov dx,0
							mov cx,100
							div cx
						pop cx

						;ax is the regen amount
						push cx
							call getHp
						pop bx

						push cx
							call getMaxHp
						pop dx
						add bx,ax

						cmp bx,dx;bx the hp after regen  dx max hp
						jl underMax
						jmp overMax

						overMax:
						push dx 
							push cx
								call setHp
						jmp continue24

						underMax:
						push bx
							push cx
								call setHp
						jmp continue24


						continue24:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 6
endp doRegen

; does recoil
proc doRecoil
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov cx, [bp+8];pokemon
						mov bx,[bp+6];move
						mov ax, [bp+4];damage
						push bx
							 call getRecoil
						pop dx

						mul dx

						push cx
							mov dx,0
							mov cx,100
							div cx
						pop cx

						;ax is the recoil amount
						push cx
							call getHp
						pop bx


						cmp bx,ax;bx the hp after regen  dx max hp
						jg recoildoesntkill
						jmp recoildoeskill

						recoildoeskill:
						mov [ex],0
						push 0 
							push cx
								call setHp
						jmp continue25

						recoildoesntkill:
						sub bx,ax

						push bx
							push cx
								call setHp
						jmp continue25


						continue25:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 6
endp doRecoil


; does flinch
proc doFlinch
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4];move
						push ax
							 call getFlinch 
						pop bx
						
						push 100
							call RandomMax
						pop cx


						cmp cx,bx;
						jg doesntFlinch
						jmp doesFlinch

						doesFlinch:
						mov [ex],0
						jmp continue26

						doesntFlinch:
						jmp continue26


						continue26:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp doFlinch

;returns the leftover after division
	;params num mod than the one to mod
PROC mod1
	push bp
		mov bp,sp
		
			push ax
				push bx
					mov ax,[bp+4]
					mov bx,[bp+6]

					cmp ax,bx
					jb continue
					

					divReplacment:
					sub ax,bx
					cmp ax,bx
					jae divReplacment
					
					continue:
					mov [bp+6],ax

				pop bx
			pop ax
		
	pop bp
	ret 2
	ENDP mod1


	;generates a random number
	PROC Random
		push ax
			push bx
				push cx
					push dx

					mov ax, [numRandom]

					
					mov bx, [aRandom]
					mov cx, [cRandom]

				
					mul bx
					
					
					; multiplies ax by bx
					add ax,cx
					
					
					mov dx,[modRandom]
					; div dx
					;doesn't work sad noises
					
					push dx
					push ax
					call mod1
					pop ax
					
					;generates random num
					;dx is the remainder
					mov [numRandom],ax

					pop dx 
				pop cx
			pop bx
		pop ax
	ret 
	ENDP Random


	;generate a random with limitation, ax is the max
	PROC RandomMax
		push bp
		mov bp,sp
		
			push ax
				push bx
					push cx
						push dx

						;moves ax the max
						; rerandom:
							mov ax,[bp+4]

							call Random
							;recaculates num
							mov bx,[numRandom]
							;moves the num into bx
							; mov cx,256

							; push cx
							; push ax
							; call mod1
							; pop ax
							; ; add sp,2
							; sub cx,ax
							; cmp bx,cx 
						; ja rerandom

						mov ax,[bp+4]

						push ax
						push bx
						call mod1
						pop bx

						mov [bp+4],bx
						
						pop dx 
					pop cx
				pop bx
			pop ax
		pop bp

	ret 
	ENDP RandomMax

; returns if a move is super effective
proc isSuperEffective
	push bp
		mov bp,sp
		push ax
			push bx
				push cx
					push dx

				
						mov bx,[bp+4];type defence
						mov ax,[bp+6];type attack

						cmp ax,1
						je normal

						cmp ax,2 
						je fire

						cmp ax,3
						je water

						cmp ax,4 
						je grass
						
						cmp ax,5
						je electric

						cmp ax,6
						je ice

						cmp ax,7
						je fighting

						cmp ax,8 
						je poison
						

						cmp ax,9
						je ground

						cmp ax,10 
						je flying

						cmp ax,11
						je psychic

						cmp ax,12
						je bug
						
						cmp ax,13
						je rock

						cmp ax,14
						je ghost

						cmp ax,15
						je dragon


						normal:
						cmp bx,13
						je notVeryEffective
						cmp bx,14
						je noEffect
						jmp nutural
						
						fire:
						cmp bx,2
						je notVeryEffective
						cmp bx,3
						je notVeryEffective
						cmp bx,4
						je veryEffective
						cmp bx,6
						je veryEffective
						cmp bx,12
						je veryEffective
						cmp  bx,13
						je notVeryEffective
						cmp bx,15
						je notVeryEffective
						jmp nutural

						water:
						cmp bx,2
						je veryEffective
						cmp bx,3
						je notVeryEffective
						cmp bx,4
						je notVeryEffective
						cmp bx,9
						je veryEffective
						cmp bx,13
						je veryEffective
						cmp bx,15
						je notVeryEffective
						jmp nutural

						grass:
						cmp bx,2 
						je notVeryEffective
						cmp bx,3
						je veryEffective
						cmp bx,4
						je notVeryEffective
						cmp bx,8
						je notVeryEffective
						cmp bx,9
						je veryEffective
						cmp bx,10
						je notVeryEffective
						cmp bx,12
						je notVeryEffective
						cmp bx,13
						je veryEffective
						cmp bx,15
						je notVeryEffective
						jmp nutural
						
						electric:
						cmp bx,3
						je veryEffective
						cmp bx , 4
						je notVeryEffective
						cmp bx, 5
						je notVeryEffective
						cmp bx,9
						je noEffect
						cmp bx,10 
						je veryEffective
						cmp bx,15
						je notVeryEffective
						jmp nutural
						
						ice:
						cmp bx,3
						je notVeryEffective
						cmp bx, 4
						je veryEffective
						cmp bx,6
						je notVeryEffective
						cmp bx,8
						je veryEffective
						cmp bx,10 
						je veryEffective
						cmp bx,15
						je veryEffective
						jmp nutural

						fighting:
						cmp bx,1
						je veryEffective
						cmp bx, 6
						je veryEffective
						cmp bx,9 
						je notVeryEffective
						cmp bx,10 
						je notVeryEffective
						cmp bx,11 
						je notVeryEffective
						cmp bx,12
						je notVeryEffective
						cmp bx,13
						je veryEffective
						cmp bx,14
						je noEffect
						jmp nutural

						poison:
						cmp bx,4
						je veryEffective
						cmp bx,8
						je notVeryEffective
						cmp bx,9 
						je notVeryEffective
						cmp bx,12
						je veryEffective
						cmp bx,13
						je notVeryEffective
						cmp bx,14
						je notVeryEffective
						jmp nutural

						ground:
						cmp bx,2
						je veryEffective
						cmp bx,4
						je notVeryEffective
						cmp bx,5
						je veryEffective
						cmp bx, 8
						je veryEffective
						cmp bx, 10 
						je noEffect
						cmp bx,12
						je notVeryEffective
						cmp bx,13
						je veryEffective
						jmp nutural
						flying:
						cmp bx,4
						je veryEffective
						cmp bx,5
						je notVeryEffective
						cmp bx,7
						je veryEffective
						cmp bx,12
						je veryEffective
						cmp bx, 13
						je notVeryEffective
						jmp nutural

						psychic:
						cmp bx, 7
						je veryEffective
						cmp bx,9
						je veryEffective
						cmp bx, 11
						je notVeryEffective
						jmp nutural

						bug:
						cmp bx,2
						je notVeryEffective
						cmp bx,4
						je veryEffective
						cmp bx,7
						je notVeryEffective
						cmp bx,9
						je veryEffective
						cmp bx,10
						je notVeryEffective
						cmp bx,11
						je veryEffective
						cmp bx,14
						je notVeryEffective
						jmp nutural

						rock:
						cmp bx,2
						je veryEffective
						cmp bx,6
						je veryEffective
						cmp bx,7
						je notVeryEffective
						cmp bx,9
						je notVeryEffective
						cmp bx,10
						je veryEffective
						cmp bx,12
						je veryEffective
						jmp nutural

						ghost: 
						cmp bx,1
						je noEffect
						cmp bx,11
						je noEffect
						cmp bx,14
						je veryEffective
						jmp nutural

						dragon:
						cmp bx,15
						je veryEffective
						jmp nutural



						notVeryEffective:
						mov [bp+6],2
						jmp continue36
						veryEffective:
						mov [bp+6],8
						jmp continue36
						noEffect:
						mov [bp+6],0
						jmp continue36
						nutural:
						mov [bp+6],4
						jmp continue36

						continue36:
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
	ret 2
endp isSuperEffective


;calculates damage
;bp +4: attack Pokemon Offset 
; +6: defence pokeman offset
; +8: move
 PROC calculateDamage
	push bp		
		mov bp,sp
		push ax
			push bx
				push cx
					push dx
					;bp+4,pokemon attack
					;bp+6, pokemon defence
					;bp+8, move 
						push [bp+4]
							call getLevel
						pop ax  
						add ax,ax
						; multiplies level by 2
						push dx
							mov dx,0
							mov cx,5
							div cx
						pop dx
						;divides by 5
						add ax,2
						push [bp+8]
							call getPower
						pop bx
						mul bx
						;multiplies by the power
						push [bp+4]
							call getEnhancedAttack
						pop bx
						;gets the attack
						push [bp+8]
							call getIsSpecial
						pop dx

						cmp dx,0
						;if  physical
						je continue1
						push [bp+4]
							call getEnhancedSpecial
							;if not physical
						pop bx

							continue1:
						mul bx
						; multiplies by the attack stat or special
						push [bp +6]
							call getEnhancedDefence
						pop dx

						;gets the attack
						push [bp+8]
							call getIsSpecial
						pop bx

						cmp bx,0	
						;if  physical
						je continue2

						push [bp+6]
							call getEnhancedSpecial
						pop dx
							;if not physical

						continue2:
						
						push cx
							mov cx,dx
							mov dx,0
							div cx

						pop cx
						; divides by either the attack or special attack
						mov dx,50d
						push cx
							mov cx,dx
							mov dx,0
							div cx
						pop cx		
						
						;divides by 50

						add ax,2


						;
						;stab
						;
						;
						push [bp+8]
							call getType
						pop bx

						push [bp+4]
							call getType1
						pop cx
						
						push [bp+4]
							call getType2
						pop dx

						cmp bx,cx
						je stab
						cmp bx,dx
						je stab 
						jmp continue3
						; if the type is the same in pokemon and move
						stab:
						mov bx,3
						mul bx
						mov bx,2
						push dx
							mov dx,0
							div bx
						pop dx
						;multiplies by 1.5
						continue3:


						; multiplies by a precent between 85 and 100
						push 15 
							call RandomMax
						pop bx
						add bx,85d

						mul bx

						mov dx, 100d
						push cx
							mov cx,dx
							mov dx,0
							div cx

						pop cx
						;super effective moves as a bonus
						push [bp+8]
							call getType
						pop bx
						push [bp+4]
							call getType1
						pop cx
						push cx
							push bx 
								call isSuperEffective
						pop bx
						mul bx
						mov bx,4
						push dx
							mov dx,0
							div bx
						pop dx
						;the first type
						push [bp+8]
							call getType
						pop bx
						push [bp+4]
							call getType2
						pop cx
						push cx
							push bx 
								call isSuperEffective
						pop bx
						mul bx
						mov bx,4
						push dx
							mov dx,0
							div bx
						pop dx
						;the second type


						;burn 
						push [bp+4]
							call getStatus
						pop bx
						cmp bx,3
						;3 is the burn status
						jne continue4

						;burn cuts physical attacks by half
						push [bp+8]
							call getIsSpecial
						pop bx
						cmp bx,1 
						je continue4

						mov dx,2
						push cx
							mov cx,dx
							mov dx,0
							div cx
						pop cx


						continue4:

						mov bx,[weather]
						cmp bx,1
						je rain
						cmp bx,2
						je sun
						jmp continue5

						rain:
						push [bp+8]
							call getType
						pop cx

						cmp cx,2
						jne continue6

						mov dx,2
						push cx
							mov cx,dx
							mov dx,0
							div cx
						pop cx
						continue6:

						cmp cx,3
						jne continue7

						mov dx,2
						mul dx

						continue7:
						

						
						sun:
						push [bp+8]
							call getType
						pop cx

						cmp cx,2
						jne continue8
						
						mov dx,2
						mul dx

						continue8:

						cmp cx,3
						jne continue5
						

						mov dx,2
						push cx
							mov cx,dx
							mov dx,0
							div cx
						pop cx
						continue5:
					 mov [bp+8] ,ax

					pop dx
				pop cx
			pop bx 
		pop ax						
	pop bp
ret 4
ENDP calculateDamage


; reorders  the pokemon so that the faster one is first
proc getFasterPokemon
	push bp
	mov bp,sp
		push ax
			push bx
				push cx
					push dx
						

						mov ax,[bp + 4]
						;ax is  pokemon1
						mov bx,[bp + 6]
						;bx is pokemon2
						mov cx,[bp + 8]
						;cx is the first pokemon's move
						mov dx,[bp + 10]
						;dx is the second pokemon's move
						push cx
							push dx 
								push cx 
									call getPriorety
								pop cx

								push dx 
									call getPriorety
								pop dx


								cmp cx,dx
							pop dx
						pop cx
						push AX
							push bx
								jb continue9
								; if the first one has priorety
							pop bx
						pop ax

						
						;flips
						push cx 
							mov cx,ax
							mov ax,bx
							mov bx,cx
						pop cx
						push ax 
							mov ax,cx
							mov cx,dx
							mov dx,ax
						pop ax
						push cx
							push dx

								push cx 
									call getPriorety
								pop cx

								push dx 
									call getPriorety
								pop dx


								cmp cx,dx
							pop dx
						pop cx
						push ax
							push bx
								jb continue10
								; if the second one has priorety
							pop bx
						pop ax
							
						push ax
							push bx

								push ax
									call getEnhancedSpeed
								pop ax

								push bx 
									call getEnhancedSpeed
								pop bx

								
								cmp ax,bx
								jb continue9
							

							pop bx
						pop ax
						;flips
						push cx 
							mov cx,ax
							mov ax,bx
							mov bx,cx
						pop cx
						push ax 
							mov ax,cx
							mov cx,dx
							mov dx,ax
						pop ax
						push ax
							push bx

								push ax
									call getEnhancedSpeed
								pop ax

								push bx 
									call getEnhancedSpeed
								pop bx

								cmp ax,bx
								jb continue10
								jmp continue9
								continue10:
								
								
								
							pop bx
						pop ax
						;flips
						push cx 
							mov cx,ax
							mov ax,bx
							mov bx,cx
						pop cx
						push ax 
							mov ax,cx
							mov cx,dx
							mov dx,ax
						pop ax
						push ax
							push bx								
								continue9:
							pop bx
						pop ax

						mov [bp+10],dx
						mov [bp+8],cx
						mov [bp+6],bx
						mov [bp+4],ax

						

					pop dx
				pop cx
			pop bx 
		pop ax						
	pop bp
ret
endp getFasterPokemon


; returns weather a opkemon is unable to move because of a status
proc isStatusBlockes
	push bp
	mov bp,sp
		push ax
			push bx
				push cx
					push dx
						

						mov ax,[bp + 4]
						;ax is  pokemon1
						mov bx,[bp + 6]
						;bx is pokemon2
						mov cx,[bp + 8]
						;cx is the first pokemon's move
						mov dx,[bp + 10]
						;dx is the second pokemon's move
						
						mov [bp+10],0
						push cx
							;paralysis
							push ax
								call getStatus
							pop cx 

							cmp cx,1
						pop cx
						jne continue19
						push cx

							push 4d
								call RandomMax
							pop cx 

							cmp cx, 0
						pop cx
						jne continue17

						mov [bp+10],1
						jmp continue17

						continue19:


						;freeze
						push cx
							push ax
								call getStatus
							pop cx 

							cmp cx,5
						pop cx
						jne continue11
						push cx

							push 8d
								call RandomMax
							pop cx 

							cmp cx, 0
						pop cx
						mov [bp+10],1
						jne continue17
						mov [bp+10],0

						push ax
							push 0
								call setStatus

						mov [bp+8],0
						jmp continue17

						continue11:


						

						
						;sleep
						push cx
							push ax
								call getStatus
							pop cx 

							cmp cx,4
						pop cx
						jne continue17
						push cx

							push 3d
								call RandomMax
							pop cx 

							cmp cx, 0
						pop cx
						mov [bp+10],1
						jne continue17
						mov [bp+10],0
						
						push ax
							push 0
								call setStatus
						jmp continue17


						continue17:

						

					pop dx
				pop cx
			pop bx 
		pop ax						
	pop bp
ret 6
endp isStatusBlockes

; returns the odds of confusing a pokemon
proc getConfusionChance
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4] 
						add bx,16d
						mov bx,[bx]
						mov [bp+4],bx
						
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getConfusionChance

proc setConfusionCounter
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+6];position
						mov ax,[bp+4];amount
						add bx, 16d
						mov [bx],ax	
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp setConfusionCounter


; makes a pokemon confused
proc causeConfusion
	push bp
	mov bp,sp
		push ax
			push bx
				push cx
					push dx
						mov ax,[bp+4];defensive pokemon 
						mov bx,[bp+6];move

						push ax
							call getConfusionCounter
						pop cx
						
						cmp cx,0
						jne continue34

						push bx 
							call getConfusionChance
						pop cx

						push 100
							call RandomMax
						pop dx

						cmp dx,cx
						jg continue35

						push 4
							call RandomMax
						pop cx
						add cx,2;random 2-5

						push ax
							push cx
								call setConfusionCounter
						jmp continue35

						continue34:
						dec cx
						push ax
							push cx
								call setConfusionCounter

						continue35:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp causeConfusion 

; returns the odds of changing a stat
proc getStatChangeChance
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4] 
						add bx,10d
						mov bx,[bx]
						mov [bp+4],bx
						
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getStatChangeChance

; returns tha stat being changed
proc getChageingStat
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4] 
						add bx,8d
						mov bx,[bx]
						mov [bp+4],bx
						
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getChageingStat

; retunrns if it is lowering opponent or raising self
proc getIsSelfStatLowering
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bx,[bp+4] 
						add bx,28d
						mov bx,[bx]
						mov [bp+4],bx
						
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getIsSelfStatLowering

; causes stat changes
proc causeStatChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax, [bp+4];offensive pokemon
						mov bx, [bp+6];offensive pokemon
						mov cx, [bp+8];move

						push cx
							call getIsSelfStatLowering
						pop dx

						cmp dx,0 
						je selfChange
						cmp dx,1
						je notSelfChange 
						jmp continue33



						selfChange:
						push cx
							push ax
								call causeIncStatChange 
						jmp continue33

						notSelfChange:
						push cx
							push bx
								call causeDecStatChange 
						jmp continue33



						continue33:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 6
endp causeStatChange


; increaes a spesific stat
proc causeIncStatChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax, [bp+4];offensive pokemon
						mov bx, [bp+6];move

						push bx
							call getStatChangeChance
						pop cx

						push 100d
							call RandomMax
						pop dx

						cmp dx,cx
						jg continue31

						push bx
							call getChageingStat
						pop cx
						
						push ax
							mov ax,2
							mul cx
							mov cx,ax
						pop ax

						add ax,27d
						add ax, cx
						;ax is the location
						mov bx,ax
						mov ax,[bx]
						;ax is the amount
						inc ax
						mov [bx],ax
						continue31: 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp causeIncStatChange

; decreaes a spesific stat
proc causeDecStatChange
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax, [bp+4];defencive pokemon
						mov bx, [bp+6];move

						push bx
							call getStatChangeChance
						pop cx

						push 100d
							call RandomMax
						pop dx

						cmp dx,cx
						jg continue32

						push bx
							call getChageingStat
						pop cx
						
						push ax
							mov ax,2
							mul cx
							mov cx,ax
						pop ax

						add ax,27d
						add ax, cx
						;ax is the location
						mov bx,ax
						mov ax,[bx]
						;ax is the amount
						inc ax
						mov [bx],ax
						continue32: 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp causeDecStatChange


; does tthe confusion calculation
proc confusionCalculation
	push bp
	mov bp,sp
		push dx
			push cx
				push bx
					push ax

					mov ax,[bp + 4]
						;ax is  pokemon1
						mov bx,[bp + 6]
						;bx is pokemon2
						mov cx,[bp + 8]
						;cx is the first pokemon's move
						mov dx,[bp + 10]
						;dx is the second pokemon's move

						mov [bp+10],0
						push cx
							push ax
								call getConfusionCounter
							pop cx
							cmp cx,0
							je continue12

							push 3
								call RandomMax
							pop cx	

							cmp cx,0
							je continue12

							push offset confusion
								push ax
									push ax 
										call calculateDamage
							pop dx
							; calculates self damage
							push ax
								call getHP
							pop cx 
							
							cmp cx,dx
							ja continue13
							
							push 0
								push ax
									call setHp
						pop cx
						jmp endTurn
						push cx
							continue13:
							sub cx,dx
							push cx
								push ax
									call setHp

						pop cx
						mov [bp+10],1	
						
						push cx
							continue12:
						pop cx
					pop ax
				pop bx
			pop cx
		pop dx
	pop bp
ret 6
endp confusionCalculation

;does a singel turn in a battle
;bp +10: pokemon2 move offset
;   +8: pokemon1 move offset
;   +6: pokemon2
;   +4 pokemon1
proc doTurn
	push bp
	mov bp,sp
		push ax
			push bx
				push cx
					push dx
					mov [ex],1; the loopy stuff

						mov ax,[bp + 4]
						;ax is  pokemon1
						mov bx,[bp + 6]
						;bx is pokemon2
						mov cx,[bp + 8]
						;cx is the first pokemon's move
						mov dx,[bp + 10]
						;dx is the second pokemon's move

						push dx
							push cx
								push bx
									push ax
										call getFasterPokemon
									pop ax
								pop bx
							pop cx
						pop dx


		; 			
						pokemonTurn:
						push dx
							push cx
								push bx
									push ax

										push dx
											push dx
												push cx
													push bx
														push ax
															call isStatusBlockes
											pop dx
											cmp dx,1 
										pop dx
										je firstPokemonEnd
							

										push dx
											push dx
												push cx
													push bx
														push ax
															call confusionCalculation
											pop dx

											cmp dx,1 
											
										pop dx
										je firstPokemonEnd

										;check if hit
										push cx
											push dx	
												push cx 
													call getAccuracy
												pop cx

												mov dx,100d
												push dx
													call RandomMax
												pop dx

												cmp dx,cx
											pop dx
										pop cx
										ja firstPokemonEnd 
										;calculate damage
										;dx was the second move now it will hold the damage
										push dx
											push cx
												push bx
													push ax 
														call calculateDamage
											pop dx
										
											; dx is the damage dealt
											push cx
												;cx will hold changing value
												push bx 
													call getHP
												pop cx

												cmp cx,dx
												jg continue14

												push 0
													push bx 
														call setHp 				
											pop ax
										pop ax
									pop ax
								pop ax
							pop ax
						pop ax						
						jmp endTurn;;;;;;;;;;;;;;;;;;;;;;;;;;
												;if move kills
												continue14:
												sub cx,dx
												push cx
													push bx
														call setHp
												;cx is the move dx is the damage ax is the pokemon
											pop cx

											push ax;pokemon
												push cx;move
													push dx;damage
														call doRecoil
											
											push ax;pokemon
												push cx;move
													push dx;damage
														call doRegen
										pop dx

										push cx
											call doFlinch
										
										push cx
											push bx
												call causeStatus
										push cx
											push bx
												push cx
													call causeStatChange 
										push cx
											push bx
												call causeConfusion
										



										firstPokemonEnd:
										
										; push ax
										; 	push bx
									pop ax
								pop bx
							pop cx
						pop dx
						push cx 
							mov cx,ax
							mov ax,bx
							mov bx,cx
						pop cx
						push ax 
							mov ax,cx
							mov cx,dx
							mov dx,ax
						pop ax
						
						; does a loop
						push ax
							mov ax, [ex]
							cmp ax,1
							mov [ex],0
						pop ax
						je pokemonTurn
						endTurn:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 8
ENDP doTurn 


; causes the pokemon tochange status
proc causeStatus
	push bp 
	mov bp,sp
		push ax
			push bx
				push cx
					push dx

						mov ax,[bp+6];move  
						mov bx,[bp+4];defencePokemon	
						push bx
							call getStatus
						pop cx
						cmp cx,0
						jne continue27

						push ax
							call getMoveStatusChance
						pop cx

						push 100
							call RandomMax
						pop dx

						cmp cx,dx
						jl continue27
						
						push ax
							call getMoveStatus
						pop ax

						push bx
							push ax
								call setStatus

						continue27:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp causeStatus

; returns what precent hp you got
proc getPrecentHp
	push bp
		mov bp,sp
		push ax
			push bx
				push cx
					push dx
						mov ax, [bp+4];the pokemon 

						push ax
							call getHp
						pop bx

						push ax
							call getMaxHp
						pop cx

						mov ax,100
						mul bx
						push dx
							mov dx,0
							div cx
						pop dx
						mov [bp+4],ax

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 
ENDP  getPrecentHp


; returns the assigned type color
proc getTypeColor
	push bp
		mov bp,sp
		push ax
			push bx
				push cx
					push dx
						mov ax,[bp+4]
						cmp ax,1
						je normalColor
						cmp ax,2
						je fireColor
						cmp ax,3
						je waterColor
						cmp ax,4
						je grassColor
						cmp ax,5
						je electricColor
						cmp ax,6
						je iceColor
						cmp ax,7
						je fightingColor
						cmp ax,8
						je poisonColor
						cmp ax,9
						je groundColor
						cmp ax,10
						je flyingColor
						cmp ax,11
						je psychicColor
						cmp ax,12
						je bugColor
						cmp ax,13
						je rockColor
						cmp ax,14
						je ghostColor
						cmp ax,15
						je dragonColor
						jmp continue20

						normalColor:
						mov [bp+4],0Fh
						jmp continue21

						fireColor:
						mov [bp+4],4h
						jmp continue21

						waterColor:
						mov [bp+4],1
						jmp continue21

						grassColor:
						mov [bp+4],02h
						jmp continue21

						electricColor:
						mov [bp+4],0Eh
						jmp continue21

						iceColor:
						mov [bp+4],0bh
						jmp continue21

						fightingColor:
						mov [bp+4],0ch
						jmp continue21

						poisonColor:
						mov [bp+4],5
						jmp continue21

						groundColor:
						mov [bp+4],6
						jmp continue21

						flyingColor:
						mov [bp+4],9
						jmp continue21

						psychicColor:
						mov [bp+4],0Dh
						jmp continue21

						bugColor:
						mov [bp+4],0Ah
						jmp continue21

						ghostColor:
						mov [bp+4],8
						jmp continue21

						rockColor:
						mov [bp+4],7
						jmp continue21
						
						dragonColor:
						mov [bp+4],3
						jmp continue21

						continue20:
						mov [bp+4],0h

						continue21:

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
endp getTypeColor


; sets the mousse position
proc setMousePosition 
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov bh,0
						mov dx,[bp+4];dh-row,dl-column
						mov ah,2
						int 10h
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 2
endp setMousePosition


; writes a char at mouse position
proc writeChar
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov dx,[bp+4];char
						mov bx,[bp+6];position
						push bx
							call setMousePosition
						mov ah,02h
						int 21h

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp writeChar

; writes two chars at mouse position
proc writeDoubleChar
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax,[bp+4];char
						mov bx,[bp+6];position
						push ax
							shl ax,4
							mov ah,0
							shr ax,4
							add ax,30h
							push bx
								push ax
									call writeChar 
						pop ax
						shl ax,4
						mov al,0
						shr ax,4
						shr ax,4
						add ax,30h
						sub bx,1
						push bx
							push ax
								call writeChar 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 4
endp writeDoubleChar


; draws a pixel
proc dot
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov cx,[bp+8]
						mov dx,[bp+6]
						mov ax,[bp+4]
						mov ah,0Ch
						int 10h 

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 6
endp dot


; draws a line
proc line
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax, [bp+10];starting x
						mov bx, [bp+8];starting y
						mov cx, [bp+6];length
						mov dx, [bp+4]; color

					
						lline:
						push ax
							push bx
								push dx
								   call dot
						inc ax

						loop lline

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 8
endp line


; draws a square
proc square
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax, [bp+12];starting x 
						mov bx, [bp+10]; starting y
						mov dx, [bp+8];width
						mov cx,[bp+6];length

						ssquare:
							push cx
								mov cx,[bp+4];color
								push ax
									push bx
										push dx
											push cx
												call line
								inc bx
							pop cx
						loop ssquare

					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 10
endp square

; draws a parimiter of a square
proc rectengle
	push bp 
	mov bp,sp 
		push ax 
			push bx 
				push cx
					push dx
						mov ax, [bp+14];starting x 
						mov bx, [bp+12]; starting y
						mov dx, [bp+10];width
						mov cx,[bp+8];length

						push ax
							push bx
								push dx
									push cx
										push [bp+6]
											call square
						inc ax
						inc bx
						sub dx,2
						sub cx,2
						
						push ax
							push bx
								push dx
									push cx
										push [bp+4]
											call square


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret 12
endp rectengle

; does the starting screen, the one that only need to be print once
proc startingGui
push 0
 push 0
	push 320d
	 push 200d
	 push 15d
	 call square
; ^white background^

push offset playerPokemon
	call getMove1
pop ax
push ax
	call getType
pop ax
push ax
	call getTypeColor
pop ax

push 4
	push 155
		push 75
			push 40
				push 0d 
					push ax
						call rectengle


push offset playerPokemon
	call getMove1
pop ax
push ax
	call getMoveNum
pop ax
push 01505h
	push ax
		call writeDoubleChar

;move1+number

push offset playerPokemon
	call getMove2
pop ax
push ax
	call getType
pop ax
push ax
	call getTypeColor
pop ax

push 83
	push 155
		push 75
			push 40
				push 0d 
					push ax
						call rectengle


push offset playerPokemon
	call getMove2
pop ax
push ax
	call getMoveNum
pop ax
push 1510h
	push ax
		call writeDoubleChar

;move2+number


push offset playerPokemon
	call getMove3
pop ax
push ax
	call getType
pop ax
push ax
	call getTypeColor
pop ax

push 162
	push 155
		push 75
			push 40
				push 0d 
					push ax
						call rectengle



push offset playerPokemon
	call getMove3
pop ax
push ax
	call getMoveNum
pop ax
push 01519h
	push ax
		call writeDoubleChar

;move3+number

push offset playerPokemon
	call getMove4
pop ax
push ax
	call getType
pop ax
push ax
	call getTypeColor
pop ax


push 241
	push 155
		push 75
			push 40
				push 0d 
					push ax
						call rectengle
						
push offset playerPokemon
	call getMove4
pop ax
push ax
	call getMoveNum
pop ax
push 01523h
	push ax
		call writeDoubleChar

;move4+number
; moves

push 5
	push 40
		push 20
			push 20
				push 0
					push 03h
						call rectengle

push offset opponentPokemon
	call getPokadexNum
pop ax
mov bx,0602h
push bx
	push ax
		call writeDoubleChar

push 295
	push 130
		push 20
			push 20
				push 0
					push 03h
						call rectengle

push offset playerPokemon
	call getPokadexNum
pop ax
mov bx,01126h
push bx
	push ax
		call writeDoubleChar


push offset playerPokemon
	call getType1
pop ax
push ax
	call getTypecolor
pop ax

push 190
	push 131
		push 50
			push 8
				push 0
					push ax
						call rectengle

push offset playerPokemon
	call getType2
pop ax
push ax
	call getTypecolor
pop ax

push 240
	push 131
		push 50
			push 8
				push 0
					push ax
						call rectengle


push offset opponentPokemon
	call getType1
pop ax
push ax
	call getTypecolor
pop ax

push 30
	push 41
		push 50
			push 8
				push 0
					push ax
						call rectengle

push offset opponentPokemon
	call getType2
pop ax
push ax
	call getTypecolor
pop ax

push 80
	push 41
		push 50
			push 8
				push 0
					push ax
						call rectengle

ret
endp startingGui

; does the changeing gui
proc gui
push 30d
	push 50d
		push 100
			push 10d
				push 12d 
					call square

mov ax,offset opponentPokemon
push ax
	call getPrecentHp
pop ax
push 30 
	push 50d
		push ax
			push 10
				push 4d
					call square

push 190
	push 140d
		push 100
			push 10
				push 12d 
					call square

mov ax,offset playerPokemon
push ax
	call getPrecentHp
pop ax

push 190 
	push 140d
		push ax
			push 10
				push 4d
					call square
; ^hp bar^


push offset playerPokemon
	call getStatus
pop ax
push 165
	push 130
		push 20
			push 20
				push 0
					push ax
						call rectengle


push offset opponentPokemon
	call getStatus
pop ax
push 135
	push 40
		push 20
			push 20
				push 0
					push ax
						call rectengle
; status

ret
endp gui


; gets a random move
proc getRandomisedMove
	push bp
		mov bp,sp
		push ax
			push bx
				push cx 
					push dx
						mov ax , [bp + 4];pokemon
						push 4
							call RandomMax
						pop bx

						cmp bx,0
						je firstMove
						
						cmp bx,1
						je secondMove

						cmp bx,2
						je thirdMove

						
						cmp bx,3
						je fourthMove

						firstMove:
						push ax
							call getMove1
						pop ax
						mov [bp+4],ax
						jmp continue22

						secondMove:
						push ax
							call getMove2
						pop ax
						mov [bp+4],ax
						jmp continue22

						thirdMove:
						push ax
							call getMove3
						pop ax
						mov [bp+4],ax
						jmp continue22

						fourthMove:
						push ax
							call getMove4
						pop ax
						mov [bp+4],ax
						jmp continue22

						continue22:
					pop dx
				pop cx
			pop bx
		pop ax
	pop bp
ret
Endp getRandomisedMove


; returns the user picked move
proc pickMove 
	push bp	
		mov bp,sp
		push ax
			push bx
				push cx 
					push dx
						mov bx,[bp+4];pokemon 
						getMove:

						mov ah, 6
						mov dl, 255
						int 21h 
						mov ah, 7
						int 21h 
						mov ah,0


						cmp ax,31h
						je pickFirstMove

						cmp ax,32h
						je pickSecondMove

						cmp ax,33h
						je pickThirdMove

						cmp ax,34h
						je pickFourthMove

						jmp getMove
						
						pickFirstMove:
						push bx
							call getMove1
						pop bx
						mov [bp+4],bx
						jmp continue23

						pickSecondMove:
						push bx
							call getMove2
						pop bx
						mov [bp+4],bx
						jmp continue23

						pickThirdMove:
						push bx
							call getMove3
						pop bx
						mov [bp+4],bx
						jmp continue23

						pickFourthMove:
						push bx
							call getMove4
						pop bx
						mov [bp+4],bx
						jmp continue23

						continue23:


					pop dx
				pop cx
			pop bx
		pop ax
	pop bp

ret
ENDP pickMove

; creates the player and opponent pokemon
proc startGame
	mov ax,  offset playerPokemon
	push ax
		call generateBattleReadyPokemon

	mov ax,  offset opponentPokemon
	push ax
		call generateBattleReadyPokemon

ret 
endp startGame

; does initializing stuff
proc starts
mov dx,0
mov cx,0
mov ah, 2ch
int 21h
add dl,dh
mov dh,0	
add dl,cl
add dl,ch
mov [numRandom],dx
push 256
	call RandomMax
pop dx
mov [numRandom],dx

;^random seed^
mov al, 13h
mov ah, 0
int 10h

;^video mode^
call startGame
call startingGui

ret
endp starts

; does damage by status
proc doStatusDamage

	push offset opponentPokemon
		call doBurnDamage
	
	push offset opponentPokemon
		call doPoisonDamage

	
	push offset opponentPokemon
		call doBadlyPoisonDamage

	
	push offset playerPokemon
		call doBurnDamage
	
	push offset playerPokemon
		call doPoisonDamage

	
	push offset playerPokemon
		call doBadlyPoisonDamage
ret
endp doStatusDamage

start:
	mov ax, @data
	mov ds, ax   
; --------------------------
; Your code here


mov dx, offset instructionmessage1
mov ah,9
int 21h

mov dx, offset instructionmessage2
mov ah,9
int 21h


mov dx, offset instructionmessage3
mov ah,9
int 21h

mov dx, offset instructionmessage4
mov ah,9
int 21h

codeStartsHere:


mov ah,1
	int 21h


call starts


		

gameLoop:

	call gui

	push offset playerPokemon
		call pickMove
	pop ax

	push offset opponentPokemon
		call getRandomisedMove
	pop bx


	push ax
		push bx
			push offset playerPokemon
				push offset opponentPokemon
					call doTurn
	
	call doStatusDamage

	mov ax, offset playerPokemon
	push ax
		call getHp
	pop ax
	cmp ax,0 
	jle opponentWin

	mov ax, offset opponentPokemon
	push ax
		call getHp
	pop ax
	cmp ax,0 
	jle playerWin

jmp gameLoop



playerWin:


push 0
	push 0 
		call setMousePosition
push 0
	 push 0
		push 320d
	 		push 200d
	 			push 15d
	 				call square 
mov dx, offset winningmessage
mov ah,9
int 21h
jmp exit
opponentWin:

push 0
	push 0 
		call setMousePosition
push 0
	 push 0
		push 320d
	 		push 200d
	 			push 15d
	 				call square 
mov dx, offset losingmessage
mov ah,9
int 21h
; --------------------------



exit:
push 0
	call doEndMessage
pop ax
cmp ax,1
je codeStartsHere

	mov ax, 4c00h
	int 21h
END start



