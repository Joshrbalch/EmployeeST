| employeesFile employeeList |


"Check for correct number of arguments"
Smalltalk arguments size >= 5 ifFalse: [
    Transcript show: 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st employees.dat count'; cr.
    " ^self halt. "
].

"Read arguments"
| employeesFile |
employeesFile := (Smalltalk arguments at: 1). "Access the last argument as the file name."
operation := (Smalltalk arguments at: 2).
Transcript show: operation; cr.

"Open and read employees file"
| file fileLines |
file := FileStream open: employeesFile mode: FileStream read. "Use fileNamed: to open the file."
file ifNotNil: [
    fileLines := file contents lines.
    file close.

    fileLines do: [:line |
        | words employeeType firstName lastName otherAttributes |
        words := line substrings.
        words isEmpty ifTrue: [^self]. "Skip empty lines"
        
        employeeType := words first.
        firstName := words second.
        lastName := words third.
        otherAttributes := words allButFirst: 3. "Extract remaining attributes"
        
        "Create employee objects based on the type"
        employeeType switch: 
            case: ['salaried'] then: [
                | salary |
                salary := otherAttributes first asNumber. "Assuming salary is the first attribute after the name"
                employeeList add: (SalariedEmployee new: firstName lastName salary)
            ].
            case: ['hourly'] then: [
                | hoursRate hoursWorked|
                hoursRate := otherAttributes first asNumber. "Assuming rate is the first attribute after the name"
                hoursWorked := otherAttributes second asNumber. "Assuming hours worked is the second attribute after the name"
                employeeList add: (HourlyEmployee new: firstName lastName hoursWorked hoursRate)
            ].
            case: ['commission'] then: [
                | sales baseCommissionRate basePay|
                sales := otherAttributes first asNumber.
                baseCommissionRate := otherAttributes second asNumber.
                basePay := otherAttributes third asNumber.
                employeeList add: (CommissionEmployee new: firstName lastName basePay sales baseCommissionRate)
            ].
         otherwise: [
            Transcript show: 'Unknown employee type: ', employeeType; cr.
        ].
    ].
] ifNil: [
    Transcript show: 'Error: Unable to open file ', employeesFile.
    ^self halt.
].


" 
Perform actions based on command-line arguments
CmdLine args at: 5 = 'count' ifTrue: [ "
    "Count employees"
    "Print count"
" ] ifFalse: [
    CmdLine args at: 5 = 'print' ifTrue: [ "
        "Print employees"
        "Print each employee's details"
    " ] ifFalse: [ "
        "Handle other actions"
    " ].
]. "
