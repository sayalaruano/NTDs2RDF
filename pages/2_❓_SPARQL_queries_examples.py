# Web app
import streamlit as st
import plotly.express as px

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

st.title('NTDs2RDF: A heterogeneous and integrated knowledge graph for the exploration of neglected tropical diseases')

st.header('Some advanced SPARQL queries and their results')

with st.container():
        st.write("### What genes are associated to Leishmaniasis and Chagas Disease (include external identifiers for Ensembl)?")
        res = runQuery(st.session_state.queries[1], st.session_state.graph)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[1], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### List 20 SNVs of genes associated to African Trypanosomiasis, including their phenotypes and chromosome locations")
        res = runQuery(st.session_state.queries[2], st.session_state.graph)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[2], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### List 10 drug-SNVs associations, including their alleles and phenotypes")
        res = runQuery(st.session_state.queries[3], st.session_state.graph)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[3], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What drugs are used to treat Chagas disease and African Trypanosomiasis (include external identifiers for PubChem)?")
        res = runQuery(st.session_state.queries[4], st.session_state.graph)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[4], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What drugs are used to treat at least two out of the three NTDs (include external identifiers for CHEMBL)?")
        res = runQuery(st.session_state.queries[5], st.session_state.graph)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[5], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What drug against Chagas disease has the highest number of protein targets?")
        res = runQuery(st.session_state.queries[6], st.session_state.graph)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[6], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What are the top 20 protein domains with the highest number of proteins encoded by genes associated to African Trypanosomiasis?")
        res = runQuery(st.session_state.queries[7], st.session_state.graph)
        fig = px.pie(res, names="proteindom_name", values="count", hole=.3)
        fig.update_traces(hoverinfo='label+percent', textinfo='value', textfont_size=15)
        st.plotly_chart(fig, use_container_width=True)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[7], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What are the top 20 biological processes with the highest number of genes associated to Leishmaniasis?")
        res = runQuery(st.session_state.queries[8], st.session_state.graph)     
        fig = px.pie(res, names="bio_processname", values="count", hole=.3)
        fig.update_traces(hoverinfo='label+percent', textinfo='value', textfont_size=15)
        st.plotly_chart(fig, use_container_width=True)
        st.write(res)       
        with st.expander("Show query"):
            st.code(st.session_state.queries[8], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What are the top 20 molecular functions  with the highest number of genes associated to Chagas Disease?")
        res = runQuery(st.session_state.queries[9], st.session_state.graph)
        fig = px.bar(res, x="mol_functname", y="count", labels={"mol_funct":"Molecular function", "count":"Number of genes"}, text_auto="True")
        fig.update_xaxes(type="category")
        fig.update_yaxes(showticklabels=False)
        st.plotly_chart(fig, use_container_width=True)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[9], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What are the top 10 cellular components with the highest number of genes associated to African Trypanosomiasis?")
        res = runQuery(st.session_state.queries[10], st.session_state.graph)
        fig = px.treemap(res, path=[px.Constant("Cellular component"), "cell_compname"], values="count", hover_data=["cell_compname","count"])
        fig.update_traces(root_color="lightgrey")
        fig.update_layout(margin = dict(t=50, l=25, r=25, b=25),
                            font=dict(size=20))
        st.plotly_chart(fig, use_container_width=True)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[10], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What are the top 30 pathways associated to the highest number of genes involved in Leishmaniasis (include the data source of the pathways)?")
        res = runQuery(st.session_state.queries[11], st.session_state.graph)
        fig = px.bar(res, x="path_name", y="count", labels={"path_name":"Pathway", "count":"Number of genes"}, text_auto="True")
        fig.update_xaxes(type="category")
        fig.update_yaxes(showticklabels=False)
        st.plotly_chart(fig, use_container_width=True)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[11], language="sparql")
        st.markdown("---")
with st.container():
        st.write("### What are the top 20 pathways associated to the highest number of genes involved in the three NTDs (include the data source of the pathways)?")
        res = runQuery(st.session_state.queries[12], st.session_state.graph)
        fig = px.pie(res, names="path_name", values="count", hole=.3)
        fig.update_traces(hoverinfo='label+percent', textinfo='value', textfont_size=15)
        st.plotly_chart(fig, use_container_width=True)
        st.write(res)
        with st.expander("Show query"):
            st.code(st.session_state.queries[12], language="sparql")
        st.markdown("---")

st.sidebar.header('Code availability')
st.sidebar.write('The code for this project is available under the [MIT License](https://mit-license.org/) in this [GitHub repo](https://github.com/sayalaruano/NTDs2RDF). If you use or modify the source code of this project, please provide the proper attributions for this work.')
st.sidebar.header('Support')
st.sidebar.write('If you like this project, please give it a star on the [GitHub repo](https://github.com/sayalaruano/NTDs2RDF) and share it with your friends. Also, you can support me by [buying me a coffee](https://www.buymeacoffee.com/sayalaruano).')
st.sidebar.header('Contact')
st.sidebar.write('If you have any comments or suggestions about this work, please DM by [twitter](https://twitter.com/sayalaruano) or [create an issue](https://github.com/sayalaruano/NTDs2RDF/issues/new) in the GitHub repository of this project.')
    


