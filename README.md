<h1 align="center">
    NTDs2RDF
</h1>

<p align="center">
    <a href="https://github.com/sayalaruano/NTDs2RDF/blob/main/LICENSE.md">
        <img alt="PyPI - License" src="https://img.shields.io/pypi/l/bioregistry" />
    </a>
    <a href="https://doi.org/10.5281/zenodo.7772555">
        <img src="https://zenodo.org/badge/DOI/10.5281/zenodo.7772555.svg" alt="DOI">
    </a>
    <a href="https://NTDs2RDF.streamlit.app/" title="NTDs2RDF"><img src="https://static.streamlit.io/badges/streamlit_badge_black_white.svg"></a>
</p>

<p align="center">
   A heterogeneous and integrated knowledge graph for the exploration of neglected tropical diseases
</p>

## **Table of contents:**
- [About the project](#about-the-project)
- [How to run the web app locally?](#how-to-run-this-app-locally)
- [Structure of the repository](#structure-of-the-repository)
- [Credits](#credits)
- [Further details](#details)
- [Contact](#contact)

## **About the project**
[Neglected tropical diseases (NTDs)](https://www.who.int/news-room/questions-and-answers/item/neglected-tropical-diseases) are a heterogeneous group of 20 bacterial, viral, parasitic, and fungal conditions that generally occur in developing tropical countries in the Americas, Africa, and Asia. NTDs mainly affect poor populations that do not have access to safe water, sanitation, and high-quality healthcare. Because of the severe effects of NTDs (i.e., they can cause long-lasting disabilities), they reinforce the cycle of poverty  in vulnerable communities.

Currently, there are several independent databases that contain information about proteins, metabolic pathways, and drugs involved in NTDs, but no integrated databases with all the information. This unified resource could enable the systematic exploration of all the components of the NTDs, contributing to the research of potential therapies for these diseases.

The **NTDs2RDF** project aimed  to create a knowledge graph (KG) of genes, proteins, metabolic pathways, gene ontologies, single nucleotide variants, 
drugs, and other relevant data for three NTDs (Chagas disease, leishmaniasis, and African trypanosomiasis), integrating all the information in a single 
data structure that can be explored through a query interface implemented with a Streamlit web application. This software provides a user-friendly platform 
to extract information from the KG using SPARQL queries.

The project represents an initial step towards the creation of a heterogeneous database for different NTDs with several potential applications in advancing the understanding of NTDs biology and  providing insights that cannot be obtained through  alternative resources.

<a href="https://NTDs2RDF.streamlit.app/" title="NTDs2RDF"><img src="https://static.streamlit.io/badges/streamlit_badge_black_white.svg"></a><br>

![NTDs2RDF-gif](img/NTDs2RDF.gif)

The schematic representation of the knowledge graph is presented in [one of the pages of the web app](https://ntds2rdf.streamlit.app/The_RDF_graph_schema). The software architecture of the web app and the previous steps are shown below:

![NTDs2RDF-arch](img/Architecture_NTDs2RDF.png)

## **How to run the web app locally?**
I used [Pipenv](https://pypi.org/project/pipenv/) to create a Python virtual environment, which allows the management of python libraries and their dependencies. Each Pipenv virtual environment has a `Pipfile` with the names and versions of libraries installed in the virtual environment, and a `Pipfile.lock`, a JSON file that contains versions of libraries and their dependencies.

To create a Python virtual environment with libraries and dependencies required for this project, you should clone this GitHub repository, open a terminal, move to the folder containing this repository, and run the following commands:

```bash
# Install pipenv
$ pip install pipenv

# Create the Python virtual environment 
$ pipenv install

# Activate the Python virtual environment 
$ pipenv shell
```

You can find a detailed guide on how to use pipenv [here](https://realpython.com/pipenv-guide/).

Alternatively, you can create a conda virtual environment with the required libraries using the `requirements.txt` file.

After installing the libraries, you can run the streamlit app locally with the command below:

```bash
$ streamlit run 🏠_Home.py
```

## **Structure of the repository**
The main files and directories of this repository are:

|File|Description|
|:-:|---|
|[RDF_graph_building.ipynb](RDF_graph_building.ipynb)|Jupyter notebook to integrate the data and create the RDF graph|
|[🏠_Home.py](🏠_Home.py)|Script for the home page of the streamlit web application|
|[sparql_queries_NTDs_RDF_examples.txt](sparql_queries_NTDs_RDF_examples.txt)|Examples of SPARQL queries to retrive information from the RDF graph|
|[requirements.txt](requirements.txt)|File with names of the libraries required for the streamlit web application|
|[Pipfile](Pipfile)|File with names and versions of libraries installed in the virtual environment|
|[Pipfile.lock](Pipfile.lock)|Json file that contains versions of libraries and their dependencies|
|[style.css](style.css)|css file to customize style features of the web application|
|[Data/](Data/)|Raw csv files and RDF graph|
|[pages/](pages/)|Python scripts for the pages of the streamlit web application|
|[Data_processing/](Data_processing/)|R scripts to collect the data|
|[img/](img/)|images and gifs|

## **Credits**
- Developed by [Sebastián Ayala Ruano](https://sayalaruano.github.io/). I created this app for a project of a course about knowledge graphs from the [MSc in Systems Biology](https://www.maastrichtuniversity.nl/education/master/systems-biology) at [Maastricht University](https://www.maastrichtuniversity.nl/).

- Part of the code for this project was inspired by the [Medium blogpost](https://python.plainenglish.io/linked-data-a-framework-for-large-scale-database-integration-d20628021d4a) and 
[GitHub repo](https://github.com/EdoWhite/ThemeParkAccidents_RDF-SPARQL) from [Edoardo Bianchi](https://medium.com/@edoardobianchi98) about this topic.

## **Further details**
More details about the data collection, integration, and processing, as well as the creation of the knowledge graph and the web app are available in this [pdf report](NTDs2RDF_report.pdf).

## **Contact**
[![](https://img.shields.io/twitter/follow/sayalaruano?style=social)](https://twitter.com/sayalaruano)

If you have comments or suggestions about this project, you can [open an issue](https://github.com/sayalaruano/NTDs2RDF/issues/new) in this repository, or email me at sebasar1245@gamil.com.
