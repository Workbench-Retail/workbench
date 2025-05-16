# Setting Up Git Submodules for Workbench Repository

This guide explains how to set up Git submodules for the repositories `automation-api-service-generator`, `automation-frontend`, `automation-config-service`, and `automation-mock-service` 

## Step-by-Step Guide

### 1. Clone the Parent Repository
Clone the `workbench` repository if not already done:
```bash
git clone https://github.com/Workbench-Retail/workbench.git
cd workbench
```

### 2. Initialize and Update Submodules
Initialize and fetch submodule contents:
```bash
git submodule update --init --recursive
```

## OR

### 1. Clone with Submodules
For others cloning `workbench`:
```bash
git clone --recurse-submodules https://github.com/Workbench-Retail/workbench.git
cd workbench
```
