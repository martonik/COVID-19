# COVID-19

These Jupyter Notebooks contain the code I used for my Data Science capstone at Northwestern University completed June 2020. I used NLP for sentiment analysis of COVID-19 and stay-at-home behavior. Analyzed daily Twitter data in Virginia to assess COVID-19 sentiment as the virus made its way through the state. Unsupervised clustering of twitter topics and statistical analysis at the county level.

Data was pulled daily from the Twitter application user interface (API) using the rtweet package in R. Data collection was limited to tweets posted in Virginia according to Twitter. Two daily pulls were run:
1.	COVID pull that uses the search terms: #COVID, COVID, COVID-19, #COVID-19, coronavirus, and #coronavirus. Data collection April 7th through May 22nd.
2.	Stay-at-home pull that uses the search terms: #stayhome, #stayathome, #Quarantine, quarantine, and #SocialDistancing. Data collection April 9th through May 22nd.

COVID-19 county level data (confirmed cases and deaths) was retrieved from the New York Times GitHub page (https://github.com/nytimes/covid-19-data). Additional county-level demographic data was be pulled from American Community Survey via Census.gov, and unemployment data from the Bureau of Labor Statistics. 

