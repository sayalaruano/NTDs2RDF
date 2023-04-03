# Web app
import streamlit as st

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

# Add a title and info about the app
st.title('NTDs2RDF: A heterogeneous and integrated knowledge graph for the exploration of neglected tropical diseases')

st.header('Meta-graph of the NTDs2RDF KG')

# Show schema of the RDF graph
schema = Image.open('img/RDF2NTDs_schema.png')
st.image(schema)

st.sidebar.header('Code availability')
st.sidebar.write('The code for this project is available under the [MIT License](https://mit-license.org/) in this [GitHub repo](https://github.com/sayalaruano/NTDs2RDF). If you use or modify the source code of this project, please provide the proper attributions for this work.')
st.sidebar.header('Support')
st.sidebar.write('If you like this project, please give it a star on the [GitHub repo](https://github.com/sayalaruano/NTDs2RDF) and share it with your friends. Also, you can support me by [buying me a coffee](https://www.buymeacoffee.com/sayalaruano).')
st.sidebar.header('Contact')
st.sidebar.write('If you have any comments or suggestions about this work, please DM by [twitter](https://twitter.com/sayalaruano) or [create an issue](https://github.com/sayalaruano/NTDs2RDF/issues/new) in the GitHub repository of this project.')
    


