#!/bin/bash

# Define the projects array
declare -a projects=(
  "./automation-api-service-generator/build-output/automation-api-service"
  "./automation-config-service"
  "./automation-frontend/frontend"
  "./automation-frontend/backend"
  "./automation-mock-service"
)

# Create a temporary workspace file
workspace_file="temp_workspace.code-workspace"
cat > "$workspace_file" <<EOF
{
  "folders": [
EOF

# Add each project directory to the workspace
for project in "${projects[@]}"; do
  if [ -d "$project" ]; then
    abs_path=$(realpath "$project")
    cat >> "$workspace_file" <<EOF
    {
      "path": "$abs_path"
    },
EOF
  fi
done

# Close the workspace JSON
echo "  ]," >> "$workspace_file"
echo '  "settings": {' >> "$workspace_file"
echo '    "terminal.integrated.defaultProfile.linux": "bash"' >> "$workspace_file"
echo '  }' >> "$workspace_file"
echo "}" >> "$workspace_file"

# Create a tasks.json in a .vscode folder at the workspace root
mkdir -p .vscode
cat > .vscode/tasks.json <<EOF
{
  "version": "2.0.0",
  "tasks": [
EOF

# Add a task for each project to run npm run dev
for project in "${projects[@]}"; do
  if [ -d "$project" ]; then
    project_name=$(basename "$project")
    abs_path=$(realpath "$project")
    cat >> .vscode/tasks.json <<EOF
    {
      "label": "Run Dev - $project_name",
      "type": "shell",
      "command": "cd $abs_path && npm run dev",
      "group": "build",
      "presentation": {
        "reveal": "always",
        "panel": "new",
        "group": "dev-group",
        "showReuseMessage": false
      },
      "problemMatcher": []
    },
    {
      "label": "Stop Dev - $project_name",
      "type": "shell",
      "command": "echo Stopping $project_name && kill -SIGINT \$(pidof node)",
      "group": "build",
      "presentation": {
        "reveal": "always",
        "panel": "new",
        "group": "dev-group",
        "showReuseMessage": false
      },
      "problemMatcher": []
    },
EOF
  fi
done

# Close the tasks.json
echo "  ]" >> .vscode/tasks.json
echo "}" >> .vscode/tasks.json

# Open the workspace in VS Code
code "$workspace_file"