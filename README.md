# IFF Hands-On Lab

Welcome to the IFF Hands-On Lab! This repository contains all the necessary files and instructions to set up and run the lab environment using Snowflake, Streamlit, and various Python packages.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Running the Demos](#running-the-demos)
- [Additional Resources](#additional-resources)

## Introduction

This lab is designed for the IFF HOL event in Paris, March 2025. It demonstrates how to use Snowflake for data analysis and visualization using Streamlit and other Python packages.

## Prerequisites

Before you begin, ensure you have the following:

- A Snowflake account with appropriate permissions.
- Python 3.11.9 installed on your machine.
- `pip` package manager.
- Access to the GitHub repository: [hol-notebook](https://github.com/Infostrux-Solutions/hol-notebook).

## Setup Instructions

1. **Clone the Repository**

   Clone the repository to your local machine:

   ```sh
   git clone https://github.com/Infostrux-Solutions/hol-notebook.git
   cd hol-notebook
   ```

2. **Set Up Snowflake Environment**

   Run the `setup.sql` script to set up the Snowflake environment:

   ```sh
   snowsql -f setup.sql
   ```

   This script will:
   - Create a new organization account.
   - Create a new database and warehouses.
   - Set up roles and permissions.
   - Create API and external access integrations.

3. **Install Python Packages**

   Install the required Python packages:

   ```sh
   pip install streamlit pandas scikit-learn rdkit
   ```

## Running the Demos

The repository contains two Jupyter notebooks (`demo1.ipynb` and `demo2.ipynb`) that demonstrate various functionalities.

1. **Demo 1**

   Open and run the `demo1.ipynb` notebook:

   ```sh
   jupyter notebook demo1.ipynb
   ```

   This notebook demonstrates:
   - Importing Python packages.
   - Using Snowpark for data analysis.
   - Generating data using SQL.
   - Converting SQL results to a Pandas DataFrame.
   - Visualizing data using Streamlit.

2. **Demo 2**

   Open and run the `demo2.ipynb` notebook:

   ```sh
   jupyter notebook demo2.ipynb
   ```

   This notebook demonstrates similar functionalities as Demo 1 with additional examples.

## Additional Resources

- [Snowflake Documentation](https://docs.snowflake.com/)
- [Streamlit Documentation](https://docs.streamlit.io/)
- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [scikit-learn Documentation](https://scikit-learn.org/stable/documentation.html)
- [RDKit Documentation](https://www.rdkit.org/docs/)

Feel free to explore and modify the notebooks to suit your needs. Happy learning!