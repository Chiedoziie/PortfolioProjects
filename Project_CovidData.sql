SELECT*
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 3,4

--SELECT*
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select Data that we are going to us

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 1,2

--looking at total cases vs total deaths
--shows likelihood of dying if you contract covid in your country

SELECT Location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%Nigeria%'
ORDER BY 1,2

SELECT Location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%kingdom%'
ORDER BY 1,2

--looking at the total cases vs the population
--shows what % of population had covid

SELECT Location, date, population, total_cases, (total_cases/population)*100 as infectionPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%Nigeria%'
ORDER BY 1,2

SELECT Location, date, population, total_cases, (total_cases/population)*100 as infectionPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%kingdom%'
ORDER BY 1,2


--looking at countries with highest infection rate against against the population

SELECT Location, population, MAX(total_cases) as highestInfectionCount, Max((total_cases/population))*100 as InfectionPercentage
FROM PortfolioProject..CovidDeaths
--Where location like '%kingdom%'
Group by location, population
ORDER BY InfectionPercentage desc

--showing the countries with the highest death count per population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%kingdom%'
Where continent is not null
Group by location
ORDER BY TotalDeathCount desc


--BY CONTINENT

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%Nigeria%'
Where continent is not null
Group by continent
ORDER BY TotalDeathCount desc


--Global numbers


SELECT SUM(new_cases) as TotalNewCases, sum(CAST(new_deaths as int)) as TotalNewDeaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where location like '%Nigeria%'
where continent is not null
--group by date
ORDER BY 1,2

--looking at total population against vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
and new_vaccinations is not null
order by 2,3







