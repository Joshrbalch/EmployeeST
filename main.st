| employeesFile employeeList |

"Check for correct number of arguments"
CmdLine args size >= 4 ifFalse: [
    Transcript show: 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st employees.dat count'. 
    ^self halt.
].

"Read arguments"
employeesFile := CmdLine args at: 4.
employeeList := OrderedCollection new.

"Open and read employees file"
(FileStream fileNamed: fileName) ifNotNil: [:file |
    fileLines := file lines.
    file close.
] ifNil: [
    Transcript show: 'Error: Unable to open file ', fileName.
    ^self halt.
].

fileLines do: [:line |
    | words employeeType firstName lastName otherAttributes |
    words := line asString split: Character space.
    words isEmpty ifTrue: [^self]. "Skip empty lines"
    
    employeeType := words first.
    firstName := words second.
    lastName := words third.
    otherAttributes := words allButFirst: 3. "Extract remaining attributes"
    
    "Create employee objects based on the type"
    employeeType caseOf: {
        ['salaried'] -> [
            | salary |
            salary := otherAttributes first asNumber. "Assuming salary is the first attribute after the name"
            employeeList add: (SalariedEmployee new: firstName lastName salary)
        ].
        ['hourly'] -> [
            | hoursRate |
            hoursRate := otherAttributes collect: [:each | each asNumber]. "Assuming hours and rate are the next two attributes after the name"
            employeeList add: (HourlyEmployee new: firstName lastName hoursRate first hoursRate second)
        ].
        ['commission'] -> [
            | sales baseCommissionRate |
            sales := otherAttributes first asNumber.
            baseCommissionRate := otherAttributes second asNumber.
            employeeList add: (CommissionEmployee new: firstName lastName sales baseCommissionRate)
        ].
    } otherwise: [
        Transcript show: 'Unknown employee type: ', employeeType; cr.
    ].
].

"Perform actions based on command-line arguments"
CmdLine args at: 5 = 'count' ifTrue: [
    "Count employees"
    "Print count"
] ifFalse: [
    CmdLine args at: 5 = 'print' ifTrue: [
        "Print employees"
        "Print each employee's details"
    ] ifFalse: [
        "Handle other actions"
    ].
].
