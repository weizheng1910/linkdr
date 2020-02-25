## Approach and Process

## What in our process and approach to this project would we do differently next time?

Splitting of workload in the initial stages would have been more efficient. There were times where once we were done with a feature we would have no structure on what next to touch on.

Have a clearer idea of user flow. 

## What in our process and approach to this project went well that we would repeat next time?

Planning ahead what technologies and methods we would use. We each took charge of what feature we wanted to work on individually.

--

## Code and Code Design
### What in our code and program design in the project would we do differently next time?

Making more use of partial views to split up components. 

### What in our code and program design in the project went well? Is there anything we would do the same next time?

For each, please include code examples that each team member wrote.

Weizheng: 


**Rachelle**
```$yellow: #fbd864;
$color1: #4f66f5;
$color2: #96c6b1;
$color3: #f54f82;

$colors: $color3, $yellow, $color1, $color2;
$repeat: 80;

@for $i from 1 through $repeat {
    .listing:nth-child(#{length($colors)}n+#{$i}) .position-title {
        background: lighten(nth($colors, random(length($colors))), 20%);
    }
}
```

Ben: 

**Stu:**

(Pagination ActiveRecord queries section for job search) 

## WDI Unit 3 Post Mortem (individual)

## What habits did I use during this unit that helped me?

Weizheng:
Rachelle: frequent commits
Ben: making use of git branches
Stu: committing all the time no matter how small the change

## What habits did I have during this unit that I can improve on?

Weizheng:
Rachelle: more testing before committing, 
Ben: 
Stu: Better communication with teammates.

## How is the overall level of the course during this unit? (instruction, course materials, etc.)

Weizheng:
Rachelle: A+
Ben: gud
Stu: A+
