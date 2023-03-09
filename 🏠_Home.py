# Web app
import streamlit as st
from rdflib import Graph

# OS and file management
from PIL import Image

# General options 
im = Image.open("img/favicon.ico")
st.set_page_config(
    page_title="NTDs2RDF",
    page_icon=im,
    layout="wide",
)

# Attach customized ccs style
with open('style.css') as f:
    st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

# Function to load the RDF graph
@st.cache_data
def importRDF(filename, format):
    graph = Graph().parse(filename, format)
    return graph

# Function to load the SPARQL queries from a file and return a dictionary
@st.cache_data
def loadQueries(filename):
    sparql_queries = {}

    with open(filename, 'r') as f:
        query_num = 1
        query = ""
        for line in f:
            if line.strip().startswith("#") and query.strip() != "":
                sparql_queries[query_num] = query.strip()
                query_num += 1
                query = ""
            else:
                query += line

    if query.strip() != "":
        sparql_queries[query_num] = query.strip()
    return sparql_queries

# Loading the RDF and sparql queries and save them in the session state
# This will be done only once and all the pages will have access to the data
if 'graph' not in st.session_state:
    st.session_state.graph = importRDF("./Data/RDF_graphs/NTDs_kg.ttl", "ttl")
if 'queries' not in st.session_state:
    st.session_state.queries = loadQueries("./sparql_queries_NTDs_RDF_examples.txt")

# Add a title and info about the app
st.title('NTDs2RDF: A heterogeneous and integrated knowledge graph for the exploration of neglected tropical diseases')
"""
[![](https://img.shields.io/github/stars/sayalaruano/NTDs2RDF?style=social)](https://github.com/sayalaruano/NTDs2RDF) &nbsp; [![](https://img.shields.io/twitter/follow/sayalaruano?style=social)](https://twitter.com/sayalaruano)
"""

with st.expander('About this app'):
    st.write('''
    [Neglected tropical diseases (NTDs)](https://www.who.int/news-room/questions-and-answers/item/neglected-tropical-diseases) are a heterogeneous group of 20 bacterial, viral, parasitic, 
    and fungal conditions that generally occur in developing tropical countries in the Americas, Africa, and Asia. NTDs mainly affect poor populations that do not have access to 
    safe water, sanitation, and high-quality healthcare. Because of the severe effects of NTDs (i.e., they can cause long-lasting disabilities), they reinforce the cycle of poverty 
    in vulnerable communities.

    Currently, there are several independent databases that contain information about proteins, metabolic pathways, and drugs involved in NTDs, but no integrated databases with all 
    the information. This unified resource could enable the systematic exploration of all the components of the NTDs, contributing to the research of potential therapies for these 
    diseases.
    
    The NTDs2RDF project aimed to create a schema and an RDF graph of proteins, metabolic pathways, drugs, and other relevant data for three NTDs (Chagas disease, leishmaniasis, and 
    African trypanosomiasis) to integrate all the information in a single data structure that can be queried to obtain novel therapeutic insights.
    
    **Credits**
    - Developed by [Sebastián Ayala Ruano](https://sayalaruano.github.io/). I created this app for a project of a course about knowledge graphs from the [MSc in Systems Biology](https://www.maastrichtuniversity.nl/education/master/systems-biology) at [Maastricht University](https://www.maastrichtuniversity.nl/).

    - Part of the code for this project was inspired by the [Medium blogpost](https://python.plainenglish.io/linked-data-a-framework-for-large-scale-database-integration-d20628021d4a) and 
    [GitHub repo](https://github.com/EdoWhite/ThemeParkAccidents_RDF-SPARQL) from [Edoardo Bianchi](https://medium.com/@edoardobianchi98) about this topic.
      ''')

st.subheader('Welcome!')
st.info('Look at the RDF graph schema and some SPARQL queries examples, or write and run your own queries', icon='👈')

st.sidebar.header('Code availability')
st.sidebar.write('The code for this project is available under the [MIT License](https://mit-license.org/) in this [GitHub repo](https://github.com/sayalaruano/NTDs2RDF). If you use or modify the source code of this project, please provide the proper attributions for this work.')
st.sidebar.header('Support')
st.sidebar.write('If you like this project, please give it a star on the [GitHub repo](https://github.com/sayalaruano/NTDs2RDF) and share it with your friends. Also, you can support me by [buying me a coffee](https://www.buymeacoffee.com/sayalaruano).')
st.sidebar.header('Contact')
st.sidebar.write('If you have any comments or suggestions about this work, please DM by [twitter](https://twitter.com/sayalaruano) or [create an issue](https://github.com/sayalaruano/NTDs2RDF/issues/new) in the GitHub repository of this project.')
    


