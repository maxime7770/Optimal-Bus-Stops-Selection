# Optimal Bus Stops Location 

This project is part of the Optimization class at MIT. It is a collaborative effort by team members [Maxime Wolf](https://www.linkedin.com/in/maxime-wolf/) and [Hayden Ratliff](https://www.linkedin.com/in/haydenratliff/).


## Introduction and Problem Description

This project addresses the critical challenge of optimizing the Massachusetts Bay Transportation Authority (MBTA) bus stop selection strategy to enhance profit margins and reduce CO2 emissions. Through a weight-based approach, we aim to refine the bus stop network, balancing economic and environmental goals under flexible constraints. This allows for the addition of future constraints by modelers or city planners. The report progresses through data sourcing and preprocessing, multiple modeling approaches, results analysis, and conclusions.

Check the `deliverables` folder to check the full report and the slides for the project.

## Data and Pre-Processing

Utilizing MBTA bus data, specifically ridership statistics and PATI bus stops information (including stop ID, name, and coordinates), we focus on the Fall 2022 season for the most recent insights. After merging these datasets, we identified discrepancies such as inconsistent stop IDs and missing stops. To mitigate this, the project concentrates on 15 key routes that are integral to the MBTA network, ensuring higher frequency standards. Where data gaps existed, stop coordinates were manually sourced from Google Maps to maintain the integrity of our analysis.

## Approaches

**Check the report for full details**

### First Model

We developed a multi-objective, mixed-integer optimization model with the following key components and assumptions:

Data Points
- $A_j$: Load after stop j
- $B_j$: Number of people unloading at stop j
- $C_j$: Number of people boarding at stop j
- $D_{j−1,j}$: Distance between two consecutive stops
- 
Model Overview
Our initial model focuses on optimizing a single route without considering variations across different time periods. Instead, it utilizes average metrics for load, boarding, and unloading across all 11 identified time periods.

Assumptions
For the purpose of simplification and modeling:

If a stop is eliminated, it is assumed that passengers who would normally board there will not use the bus service at all.
Passengers intending to alight at a removed stop are assumed to disembark at the subsequent selected stop.
While these assumptions may not perfectly reflect real-world behavior, they are essential for the feasibility of the model.

### Second Model

Our second model is much more complex because it takes into account all 11 time periods. Because the model takes into
account all time periods, it can select different combinations of bus stops for each time period. For example, some stops
might be selected regardless of the time of the day, while other stops might only be selected during the AM or PM rush
hours.


## Results

The following plots show the pareto-optimal frontiers and the number of stops. This illustrates the trade-off we incorporate into the objective function.

<img width="854" alt="Screenshot 2024-02-26 at 12 52 02 PM" src="https://github.com/maxime7770/Optimal-Bus-Stops-Selection/assets/58089609/3053dc51-d22c-4849-8d15-44853f117d0d">

Our approach is flexible and one can easily add constraints depending on the context and the use case.

<img width="1145" alt="Screenshot 2024-02-26 at 12 54 55 PM" src="https://github.com/maxime7770/Optimal-Bus-Stops-Selection/assets/58089609/aaabcda5-73ce-40e2-9359-e24f7e1a54c7">

- In the first case, we observe 55.9% CO2 emissions decrease 18.2% profit decrease.
- In the second case (without removing consecutive stops), we observe 28.4% CO2 emissions decrease 11.5% profit decrease
This illustrates the trade-off between deserving as many areas as possible and the efficiency of the selection.



Finally, we visualize the solution for the 2nd model at different times of the day.

<img width="1175" alt="Screenshot 2024-02-26 at 12 56 15 PM" src="https://github.com/maxime7770/Optimal-Bus-Stops-Selection/assets/58089609/06423251-2ec3-4a35-a26d-3007a0bffc50">

For instance:
- PM Peak and Evening have been assigned to the same group by our model so the solution is the same
- Midday: people are working in Boston
- PM Peak / Evening: people are traveling between Cambridge and Boston to go back home
- Night: fewer stops because fewer people take the bus






