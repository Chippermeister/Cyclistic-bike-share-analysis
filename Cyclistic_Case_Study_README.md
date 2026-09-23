# Cyclistic Bike-Share Project

**Tools:** Google Sheets, BigQuery (SQL), Tableau
**Dashboard:** https://public.tableau.com/app/profile/chip.meyer/viz/Cyclistic_Project_17733701473760/Dashboard1
**SQL:** see `cyclistic_sql_reconstruction.sql` in this repo
**Roadmap:** [Case Study Roadmap](https://docs.google.com/document/d/1aC11RaAtZRi7-01WkKut368RZKI_YSPm1tspzdvOMQo/edit?tab=t.0#heading=h.ugqbm636tsul)

## Intro

Hello, my name is Chip Meyer and I am an aspiring data analyst working my way through the Google Data Analytics course. This project is a capstone that utilized all of the skills I have learned from following along with the course. This document outlines my methods of analyzing the data given to me for this project and shares my findings with charts created in the Tableau visualization software.

I chose to do the project with the fictional Cyclistic bike-share company because it aligned with my life goals of wanting to create more access to outdoor activities and sports. Here I was presented with an opportunity to create my first data analysis on some data that could be useful to the upper management of the fictional company. They wanted to learn the differences between casual riders and full paying annual members, and how they could create a marketing campaign that would convert more casuals into members. For this I had to gather, clean, analyze, visualize, and present my findings so that the stakeholders could make a marketing campaign decision.

## Roadmap

I began by creating a roadmap to fill out at certain points in my process, which helped me document each of the important steps taken in my analysis. Throughout the project I filled in the important information so that I would have notes to refer back to if I ever got lost in my analysis.

## Collect

I was presented with a trove of monthly ride data at [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html), a reservoir of all the monthly data on rides taken going back several years, given in compressed .csv files. The license for use of these files is [here](https://divvybikes.com/data-license-agreement). I selected the last 12 months of files, unpacked them, and organized them into a secure folder on my desktop PC at home. From there I attempted to import the files into my Google Drive to view on Google Sheets.

The first issue I ran into with the data was that some of the monthly files were too large to be imported straight into Google Sheets, so I had to come up with another way of viewing the large files. I then imported them into Google's BigQuery so that I could analyze them using SQL. I created backups of all the original data and made sure they were secure if I ran into issues stemming from my data cleaning and analysis.

## Clean

From there I had to combine all the monthly tables into one large table so that I could more easily clean and analyze the data. I did this using the `CREATE TABLE` and `UNION ALL` functions to make one large file with over 6 million rows. Now I could clean the data with all the tables in one place.

To clean the data I started by removing duplicate entries from the primary key column, which was the Ride ID. Once I knew there were no duplicates, I noticed that there were many rides with missing location data for either the starting or ending station, or missing latitude and longitude for the start or end. There was nothing I could do in this case to fix that null data, but in other circumstances I could inquire as to how to obtain the missing data from other sources from stakeholders.

## Analyze

Now that I had the data cleaned, I was able to move onto analysis. I asked specific questions of the data to find out important information about the customers:

- Do casuals or members ride more?
- Do casuals or members ride more on weekdays or weekends?
- How often do the rides end in the same place they were started?
- Do casuals or members take longer rides?
- Do casuals or members ride more classic or electric bikes?

I was able to answer a few of those questions through SQL queries and got a sense of where the data was leading me. In order to really see what the data was telling me, I had to import it into Tableau and create some visualizations to better view the data.

## Visualize

From within Tableau, I created 5 different charts which showed the answers to the questions I had of the data, and merged them into one visually appealing dashboard. The dashboard is [here](https://public.tableau.com/app/profile/chip.meyer/viz/Cyclistic_Project_17733701473760/Dashboard1).

## The Findings

I found that the two charts signaling the largest difference between casual riders and full members are the days of the week that they tend to ride. Members generally ride on weekdays, signaling that they may be using their membership to commute to work. Casual riders tend to ride more on the weekends, showing them riding more for fun and recreation. This conclusion is backed up by my heatmap chart of downtown Chicago, which shows more casual riders starting rides down at the river district. This seems to be the place where casual riders are taking a nice leisurely ride around the river area and taking in the sights of Chicago by the water.

The data shows a similar trend throughout the full year: people of both rider types will ride more in the summer and less in the winter. It also shows that both types of riders prefer the electric bikes over the classic bikes. The major difference between the two types of riders then seems to be the days of the week which they ride.

## Share

My analysis led me to the conclusion that we must create a marketing campaign to push more of the casual riders to become weekday commuters. I have three recommendations for campaign ideas which promote this switch:

- Create a viral campaign across the city which promotes the benefits of commuting to work on a bike vs. a car (cost benefits, traffic avoidance, parking considerations, and ease of access).
- Target specific areas in the city where casual riders are taking their leisurely rides on weekends and make a push for them to upgrade their membership, with flyers posted around those areas.
- Offer a promotional deal to upgrade to a full membership at a discounted rate for riders who want to become work commuters on bikes.

These promotional ideas can be iterated on and improved by the marketing team, but they are the foundation for my recommendations based on the data provided by the company.

In conclusion, to the stakeholders of the fictional company Cyclistic, and to any potential future employers reading this, I hope this presentation does a great job of showcasing my skills as a data analyst and proves that I am capable of taking big data and solving real world problems with it.

---

**Sources**
Data: https://divvy-tripdata.s3.amazonaws.com/index.html
License: https://divvybikes.com/data-license-agreement
