# Modeling the Bias between Number of Confirmed Cases and Actual Number of Infections in COVID-19 Pandemic

The preprint is available for download in https://www.medrxiv.org/content/10.1101/2020.06.22.20137208v1

Authors: **Xingang Chen**, Institute for Theory and Computation, Harvard-Smithsonian Center for Astrophysics, 60 Garden Street, Cambridge, MA 02138, USA; 
**Dhiraj Kumar Hazra**,The Institute of Mathematical Sciences, HBNI, CIT Campus, Chennai 600113, India

## Information regarding the article

The actual number of COVID-19 infections is a key to understanding the transmis- sion of the disease. It is also a critical factor for policy-making during the pandemic. However, the number of confirmed cases in viral tests is only a biased probe of this number. A general method of predicting the actual number of infections from the measured variables, such as the total tests, confirmed cases, hospitalizations and fatalities, is unavailable. In the article (https://www.medrxiv.org/content/10.1101/2020.06.22.20137208v1), we achieve this by developing a model that motivates a method of data analyses of these variables. By comparing with the historical data of the USA in the past few months, we find a simple formula relating these four variables. Among a few applications, we show how the model can be used to predict the number of actual infections and the optimal test volume. This repository is to provide the data and code we have used for our analysis.


## Brief information about the supplied data 

Here we provide the relevant data used in our analysis. Note that we have collected all the data from the website https://covidtracking.com. Thereafter we correct for the gliches in the data using the methods described in the **Data collection** section of the preprint. We bin the data using binning method described in **Some data analyses details and plots** section. Here we provide the unbinned data in the input_data folder. Unbinned data for each states are provided where first column is *T/H_N* and second column is *p_+/H_N*. We fit *T/H_N* as a function of *p_+/H_N*. 



## Brief description of the code

We also provide the code to obtain the best fit to the curve given a particular function. Here we supply the example of Tangent function. But the code can be used to fit other functional forms as well. 
