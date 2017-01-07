# Twitter timeline

### Retrieve and your Twitter timeline and plot the most active tweeters

Uses the [TwitteR](https://cran.r-project.org/package=twitteR) R package.

## Steps

1. Create a Twitter app at https://apps.twitter.com/app/new

2. Copy `credentials.R.example` to `credentials.R` and add the credentials for your Twitter app.

## Output

`report` summarizes tweets by `screenName` and shows you the most active tweeters in your timeline.

```
> head(report, n = 20)
# A tibble: 20 × 5
       screenName tweets retweets replies total
            <chr>  <int>    <int>   <int> <int>
1      DMRegister     75       17       0    92
2       davidfrum     17       12      16    45
3          marick      8       15       9    32
4    JamesFallows     15        6       5    26
5     deanwampler      7       15       0    22
6          maddow     17        5       0    22
7     paulkrugman     12        0       9    21
8        ACLUiowa      7       12       0    19
9         mtaibbi     17        2       0    19
10      Rbloggers     18        0       0    18
11      gigasquid      2       13       0    15
12      joshbloch      3       10       2    15
13    Capncavedan      5        4       4    13
14        Snowden      4        3       5    12
15            EFF      9        1       0    10
16         fitbit      7        3       0    10
17     juliasilge      3        4       3    10
18 VerifiedVoting     10        0       0    10
19  aaron_hoffman      9        0       0     9
20   AnnaPawlicka      3        6       0     9
```

`long_report` contains the same data but in a format convenient for plotting.

```
> head(long_report)
# A tibble: 6 × 4
    screenName   type count    percent
         <chr>  <chr> <int>      <dbl>
1   DMRegister tweets    75 0.14677104
2    davidfrum tweets    17 0.03326810
3       marick tweets     8 0.01565558
4 JamesFallows tweets    15 0.02935421
5  deanwampler tweets     7 0.01369863
6       maddow tweets    17 0.03326810
```

The plot looks like this.

![most active tweeters](images/most_active_tweeters.png)
