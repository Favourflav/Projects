

Select *
from Project..CovidDeaths$
order by 1,2

Select *
from Project..['Covid Vaccinations]
order by 3,4

select Location, date, total_cases, new_cases, total_deaths,population 
From Project..CovidDeaths$
order by 1,2

select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Project..CovidDeaths$
Where location like '%states%'
order by 1,2

select Location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
From Project..CovidDeaths$
Where location like '%states%'
order by 1,2

select Location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
From Project..CovidDeaths$
Where location like '%states%'
order by 1,2

select Location, population, MAX(total_cases) as HighestInfection, MAX((total_cases/population))*100 as PercentageInfected
From Project..CovidDeaths$
---Where location like '%states%'
Group by location, population
order by PercentageInfected desc


select continent, MAX(cast(total_deaths as int)) as HighestDeaths
From Project..CovidDeaths$
Where continent is not null
Group by continent
order by HighestDeaths desc

 
 select continent, MAX(cast(total_deaths as int)) as HighestDeaths
From Project..CovidDeaths$
Where continent is not null
Group by continent
order by HighestDeaths desc




select date, SUM(new_cases), SUM(cast(new_deaths as int)), SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From Project..CovidDeaths$
Where continent is not null
Group by date
order by 1 ,2

-------------------------------------------------------------------------------------
Select continent, location, date, (new_cases/population)*100 as incidence_rate
From Project..CovidDeaths$


#Global Death Percentage

select  date, SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Project..CovidDeaths$
Where continent is not null
Group By date
order by 1,2


#Global Population that has been vaccinated

Select Death.location, Death.location, Death.date, Death.population, Vacc.new_vaccinations
from Project..CovidDeaths$ Death
join Project..['Covid Vaccinations] Vacc
on  Death.location =  Vacc.location
and Death.date =  Vacc.date
where Death.continent is not null
order by 2,3

#Rolling Sum of vaccination

Select Death.continent, Death.location, Death.date, Death.population, Vacc.new_vaccinations
, SUM(CONVERT(int, Vacc.new_vaccinations)) OVER (Partition by Date.location order by 
Date.location, Date.date) as RollingVaccination
from Project..CovidDeaths$ Death
join Project..['Covid Vaccinations] Vacc
on  Death.location =  Vacc.location
and Death.date =  Vacc.date
where Death.continent is not null
order by 2,3

