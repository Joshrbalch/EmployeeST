Object subclass: Check [
    | value operation threshold |

    operation := 'eq' ifTrue: [
        value = threshold ifTrue: [^true] ifFalse: [^false] 
    ]

    operation := 'ne' ifTrue: [
        value ~= threshold ifTrue: [^true] ifFalse: [^false] 
    ]

    operation := 'gt' ifTrue: [
        value > threshold ifTrue: [^true] ifFalse: [^false] 
    ]

    operation := 'lt' ifTrue: [
        value < threshold ifTrue: [^true] ifFalse: [^false] 
    ]

    operation := 'ge' ifTrue: [
        value >= threshold ifTrue: [^true] ifFalse: [^false] 
    ]

    operation := 'le' ifTrue: [
        value <= threshold ifTrue: [^true] ifFalse: [^false] 
    ]

    ^false


]