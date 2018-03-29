# PubCode
## Code for the Scientific Community
---  

[<img src="img/pubcode-search.png">](site.link)

PubCode is a prototype platform for developers to present their code in a formal environment, while showcasing useful metadata regarding the development, upkeep, and activity levels of their code to prospective users.  Enhancing the users search for an appropriate tool for their given task provides an incentive to cite these open source tools, providing further interest in both its use and development.  

---

## What’s the Problem?  
Computational analysis of biological and clinical data is becoming more important. As a result, researchers often find themselves needing code to complete a specific task, but find that much of the available code is not well-documented, maintained, or user-friendly. Allowing researchers to search for code and quickly limit the results based on user-friendliness (i.e. measured by the presence of reproducible examples), upkeep (i.e. measured by the number of closed issues on GitHub), and popularity (i.e. measured by the number of stars on GitHub and/or number of citations on peer-reviewed papers) would greatly benefit their search experience. At the same time, the existence of this platform and the knowledge that users search based on these metadata would potentially motivate developers to develop code that is better documented, maintained, and user-friendly.

---

[<img src="img/pubcode-home.png">](site.link)

---

## What is PubCode?
At this moment, PubCode demos a selection of software with both scientific publications and GitHub repositories.  Though limited in its current state, users can search for tools by keyword and further limit their research results based on metadata concerning how thoroughly the code is being maintained and used. Moreover, users can obtain clusters of similar code as a proxy to the uniqueness of the software, and also determine whether the use and popularity of the software is increasing or decreasing in recent years among its cohort of similar software.  

---

[<img src="img/pubcode-results.png">](site.link)

---

## Viewing how a group of software impact compares over time

A particular query may result in a small cluster of potential code options. To guide the user into determining which code to consider first, we may wish to provide a metric that demonstrates how the clusters of codes that matched their query have demonstrated quantifiable impact over the years. While we are still determining what type of metric to use to measure "impact", one possibility in the meantime is the U-Index.

Another group recently has developed the U-Index, which compares software impact over time under the argument that success is directly proportional to the ratio of usage citations to awareness citations, and indirectly proportional to the number of years since the code was published. Further information about the U-Index can be found at [Callahan et al.](https://www.nature.com/articles/sdata201843). Using something like the U-Index would complement the other features of PubCode very well.

As part of their communication to users about how different software within a cluster were having impact over time (as measured by U-Index), they showed line plots that were static and could be difficult to zoom into the details. An example is in the static Figure 2 of their paper. We recreated a similar plot demonstrating software U-Index score over time using an interactive line plot that allow users to hover and retrieve information as well as zooming and panning functionality. Hence, if we were to use a similar feature in PubCode, we could consider creating an interactive line plot showing the U-Index of a cluster of similar software.

An example of the static plot of Figure 2A from [Callahan et al.](https://www.nature.com/articles/sdata201843) and its interactive version we created can be viewed at: https://pubcode.shinyapps.io/interactiveuindex/. The code that scraps the U-Indices from the supplementary files of [Callahan et al.](https://www.nature.com/articles/sdata201843) and plots them can be found in the Shiny directory of this repository.

---

## PubCode Metadata
- PubMed Citations
- Impact Factor of Journal (2016)
- GitHub Stars
- Commits
- Forks
- Installation Instructions (Yes/No)
- Examples (Yes/No)
- Sample Data (Yes/No)
- Open Source (Yes/No)
- Open Issues
- Closed Issues

---
## Future Directions
Integration of a quality metric will require designation of attributes that indicate a code will be “successful”.
- Citations/Year for various sequence aligners
- Literature highlighting Bowtie v Bowtie2
- u-INDEX Callahan et al. (2018)

## Development and Installation Instructions

### Using Docker
1. Install the Docker Community Edition (CE).
2. Start the docker daemon.
3. Copy the [docker-compose.yml](docker-compose.yml) file to your local computer.
4. Run the command `docker-compose up`.
5. Access the home page of PubCode through "localhost:8000/index.html".
6. The postgreSQL database is accessible through port 5432 on localhost.

### Development Instructions
#### Backend Server
- All server code is contained with the [server](server) folder and is based in nodejs.
- Once in the server folder, run `npm i` to install all dependencies.
- Use `npm start run` to start the Express server locally. The backend server is accessible through "localhost:5000".

## PubCode Team  
[Michael Chambers](https://github.com/greenkidneybean) (Team Writer)  
[Sean Maden](https://github.com/metamaden)  
[Aynex Mercado](https://github.com/aynexm)  
[Lindsay Rutter](https://github.com/lrutter) (Team Lead)  
[Anna Salvador](https://github.com/annacsalvador)  
[Sunny Yu](https://github.com/sunnielyu) (System Administrator)  

---

![banner](img/pubcode-banner.png)
