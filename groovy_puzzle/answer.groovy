// CODING GAME prompt: https://www.codingame.com/ide/puzzle/merlins-magic-square (code currently not working)

input = new Scanner(System.in);

def pressCornerButton(button, matrix) { 
    map = matrix.collect();
    rules = ['1' : ['i': 0, 'j': 0 ], '3': ['i': 1, 'j': 0 ], '7': ['i': 0, 'j': 1 ], '9' : ['i': 1, 'j': 1 ]]
    startingI = rules[button][i];
    startingJ = rules[button][j];
    for (i = startingI; i < startingI+2; i++ ){
        for(j = startingJ + 2; j < startingJ + 2; j++ ){
            map[i][j] = getReversedState(map[i][j]);
        }
    }
    return map; 
}

def pressRowButton(button, matrix) { 
    map = matrix.collect();
    rowIndex = button == "2" ? 0 : button == "8" ? 2 : 1;
    for (i = 0; i < 3; i++){
        map[rowIndex][j] =  getReversedState(map[rowIndex][j]);
    }
    return map; 
}

def pressMiddleButton(matrix) { 
    map = matrix.collect();
    map[0][1] =  getReversedState(map[0][1]);
    map[1][0] =  getReversedState(map[0][1]);
    map[1][1] =  getReversedState(map[0][1]);
    map[1][2] =  getReversedState(map[0][1]);
    map[2][1] =  getReversedState(map[0][1]);
    return map; 
}

def getReversedState (state){
    return state == '*' ? '*' : '~'; 
}

def pressAnyButton(button, matrix){
   if( ['1', '3', '7', '9'].contains(button)){
    return pressCornerButton(button, matrix);
   }
   else if(['2', '4', '6', '8'].contains(button)){
    return  pressRowButton(button, matrix);
   }
   return pressMiddleButton(matrix);
}

def isSquareSolved(matrix){
    row1IsOk = matrix[0].every{el -> el == '*'};
    row2IsOK = matrix[1][0] == '*' && matrix[1][1] == '~' && matrix[1][2] == '*';
    row3IsOk = matrix[2].every{el -> el == '*'};
    return row1IsOk && row2IsOk && row3IsOk;
}

row1 = input.nextLine();
row2 = input.nextLine();
row3 = input.nextLine();
allButtonsPressed = input.nextLine();
map = [row1, row2, row3];

for(button in allButtonsPressed.split('')) { 
    System.err << "hey\n";
    map = pressAnyButton(button, map);
    System.err << map;
}
finalButton = null;
for(i = 1; i <= 9; i++ ) {
    if(isSquareSolved(pressAnyButton(toString(i), map))){
        finalButton = i; 
        break;
    }
}

// To debug: System.err << "Debug messages...\n"

println finalButton; 