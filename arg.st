"Check for correct number of arguments"
Smalltalk arguments size >= 2 ifFalse: [
    Transcript show: 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st employees.dat count'; cr.
    " ^self halt. "
].

"Read arguments"
| employeesFile file |
file := FileStream open: (Smalltalk arguments at: 1) mode: FileStream read.

file ifNil: [
    Transcript show: 'Error: Unable to open file'; cr.
    ^self halt.
].

"Process file content"
[file atEnd] whileFalse: [
    | line words |
    line := file nextLine.
    words := line substrings.
    (words at: 1) = 'hourly' ifTrue: [
        1 to: words size do: [ :i |
            Transcript show: (words at: i); cr.
        ].
        " Transcript cr. "
    ]
].

"Close the file"
file close.
