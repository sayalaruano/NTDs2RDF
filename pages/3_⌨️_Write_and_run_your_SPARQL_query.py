# Web app
import streamlit as st

# Data analysis
import pandas as pd

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

# Function to convert the query result into a dataframe
def sparql_results_to_df(results):
    return pd.DataFrame(
        data=([None if x is None else x.toPython() for x in row] for row in results),
        columns=[str(x) for x in results.vars],
    )

# Function to run a SPARQL query
def runQuery(query, executor):
    result = executor.query(query)
    res_df = sparql_results_to_df(result)
    return res_df

# Set the session state to store the sparql query
if 'sparql_query_input' not in st.session_state:
    st.session_state.sparql_query_input = ''

# Add a sidebar with the options
def example_sparql_query():
    st.session_state.sparql_query_input = """# List 5 gene IDs and names from the NTDs knowledge graph
    PREFIX ncit: <http://ncicb.nci.nih.gov/xml/owl/EVS/Thesaurus.owl#>
    PREFIX sio: <http://semanticscience.org/resource/>

    SELECT ?gene ?genename
    WHERE {    
    ?gene a ncit:C16612;
    sio:SIO_000300 ?genename;
    }
    LIMIT 5
    """

def clear_sparql_query():
    st.session_state.sparql_query_input = ''

st.title('NTDs2RDF: A heterogeneous and integrated knowledge graph for the exploration of neglected tropical diseases')

sparql_query = st.sidebar.text_area('Enter your SPARQL query and press Ctrl+Enter', st.session_state.sparql_query_input, key='sparql_query_input', help='Be sure to write the query in the SPARQL syntax', height=200)

st.sidebar.button('Simple example of SPARQL query', on_click=example_sparql_query)
st.sidebar.button('Clear input', on_click=clear_sparql_query)

# Add states to the session state to store the sparql query 
if st.session_state.sparql_query_input == '':
    st.info('Enter your SPARQL query or look at some examples in the sidebar', icon='👈')
elif st.session_state.sparql_query_input != '':
    with st.container():
        try:
            res = runQuery(sparql_query, st.session_state.graph)
            st.write(res)
            with st.expander("Show query"):
                st.code(sparql_query, language="sparql")
            st.markdown("---")
        except:
            st.error("Error! Check your query syntax...")
            st.markdown("---")

st.sidebar.header('Code availability')
st.sidebar.write('The code for this project is available under the [MIT License](https://mit-license.org/) in this [GitHub repo](https://github.com/sayalaruano/NTDs2RDF). If you use or modify the source code of this project, please provide the proper attributions for this work.')
st.sidebar.header('Support')
st.sidebar.write('If you like this project, please give it a star on the [GitHub repo](https://github.com/sayalaruano/NTDs2RDF) and share it with your friends. Also, you can support me by [buying me a coffee](https://www.buymeacoffee.com/sayalaruano).')
st.sidebar.header('Contact')
st.sidebar.write('If you have any comments or suggestions about this work, please DM by [twitter](https://twitter.com/sayalaruano) or [create an issue](https://github.com/sayalaruano/NTDs2RDF/issues/new) in the GitHub repository of this project.')
    


