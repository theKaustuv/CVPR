WORD SEGMENTING PROGRAM
-----------------------------------------------------------

NOTES FOR USING:

1. OPEN MATLAB AND RUN THE  FILE NAMED 'mousePicker2.m'

2. THE LANGUAGE FOLDERS (MENTIONED BELOW) SHOULD BE IN THE SAME DIRECTORY WITH THE ABOVE MENTIONED FILE.

3. RUN THE PROGRAM AND BROWSE THE IMAGE PATH or COPY THE IMAGE PATH(FULL PATH) TO THE 'IMAGE PATH' FIELD IN THE APPLICATION AND CLICK 'OPEN'.

4. CHOOSE  'Auto Selection' or 'Manual Selection'

5.FOR 'Auto Selection'-CROPPED WORD WILL COME AUTOMATICALLY and CHOOSE 'Yes' or 'No' ACCORDINGLY , WHETHER THE CROPPED WORD IS CORRECT OR NOT .

6.FOR  'Manual Selection'- YOU NEED TO SELECT EACH WORD BY CLICKING ON TWO POSITIONS ON THE IMAGE 
SO THAT THE WORD CAN BE CROPPED.

7. SELECT THE REQUIRED LANGUAGE FROM LANGUAGE LIST.

8. CLICK 'Accept'.

9.  CONTINUE THIS FOR OTHER IMAGES ALSO.

NOTE:
1. COORDINATES WILL BE SHOWN BELOW THE IMAGE ALONG WITH THE CROPPED PORTION.
2. THE FOLDER NAMES SHOULD NOT BE CHANGED.
3. IF A SELECTED PART IS NOT TO BE SAVED, JUST SELECT ANOTHER ONE WITHOUT CLICKING 'Accept'
4. WHENEVER AN "Auto-Selection" IS STARTED, IT ALWAYS STARTS FROM THE VERY FIRST WORD.
5. THE SAVED FILENAME HAS THE FOLLOWING FORMAT :
	<InputFile>_<X1>_<Y1>_<X2>_<Y2>.TIF
	WHERE, <InputFile> IS THE NAME(WITHOUT EXTENSION) OF THE INPUT FILE.
	(<X1>,<Y1>) IS THE COORDINATE OF THE UPPER-LEFT CORNER OF THE SELECTED PART.
	(<X2>,<Y2>) IS THE COORDINATE OF THE LOWER-RIGHT CORNER OF THE SELECTED PART.


LANGUAGE:		FOLDER_NAME:
1.Bengali 			BE
2.Englsih			EN
3.Hindi			HI
4.Tamil			TA
5.Telegu			TE
6.Malayalam 		MA
7.Gurumukhi 		GM
8.Gujrati 			GR
9.Oriya			OR
10.Kanada 		KA
11.Urdu			UR
12.For Common['?',';',...etc]      CO
13.Error			ER