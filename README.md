# Twitter timeline

### Retrieve and your Twitter timeline and plot the most active tweeters

Uses the [rtweet](http://rtweet.info/) R package.

## Setup

See the [rtweet](http://rtweet.info/) documentation for how to set up a Twitter app and API authorization.

## Output

`report` summarizes tweets by `screenName` and shows you the most active tweeters in your timeline.

```
> print(report)
# A tibble: 189 x 5
   screen_name   tweets retweets replies total
   <chr>          <int>    <int>   <int> <int>
 1 NateSilver538     13        8       4    25
 2 joshbloch          8       11       2    21
 3 paulkrugman       11        0       7    18
 4 aaron_hoffman      7        8       1    16
 5 NWSDesMoines      15        0       0    15
 6 leebrandt          4       10       0    14
 7 PythonWeekly      14        0       0    14
 8 linuxjournal      11        2       0    13
 9 maddow             3       10       0    13
10 RobSandIA          5        8       0    13
# ... with 179 more rows
```

`long_report` contains the same data but in a format convenient for plotting.

```
> print(long_report)
# A tibble: 81 x 4
   screen_name   type   count percent
   <chr>         <chr>  <int>   <dbl>
 1 NateSilver538 tweets    13 0.0181 
 2 joshbloch     tweets     8 0.0111 
 3 paulkrugman   tweets    11 0.0153 
 4 aaron_hoffman tweets     7 0.00975
 5 NWSDesMoines  tweets    15 0.0209 
 6 leebrandt     tweets     4 0.00557
 7 PythonWeekly  tweets    14 0.0195 
 8 linuxjournal  tweets    11 0.0153 
 9 maddow        tweets     3 0.00418
10 RobSandIA     tweets     5 0.00696
# ... with 71 more rows
```

The plot looks like this.

![most active tweeters](images/most_active_tweeters.png)
