# 🔌 Jenkins Plugins - Complete Reference Guide

## What Each Plugin Does & Which Lab Uses It

---

## 🔵 Pipeline & Core Plugins

| Plugin | What It Does | Used In Lab | Example Usage in Jenkinsfile |
|--------|-------------|-------------|------------------------------|
| **docker-workflow** | Build/run Docker images from pipeline | Lab 07 | `docker.build("myapp:${BUILD_NUMBER}")` |
| **credentials-binding** | Inject credentials as env vars | Lab 03, 11 | `credentials('my-cred-id')` |
| **pipeline-groovy-lib** | Load shared Groovy libraries | Lab 04, 13 | `@Library('my-lib') _` |
| **pipeline-utility-steps** | Read JSON/YAML, find files, zip | All | `readJSON file: 'config.json'` |
| **pipeline-stage-view** | Visual stage execution view | All | Automatic (shows in UI) |
| **pipeline-build-step** | Trigger other jobs from pipeline | Lab 05 | `build job: 'downstream'` |
| **pipeline-input-step** | Manual approval gates | Lab 10 | `input message: 'Deploy to prod?'` |
| **pipeline-milestone-step** | Cancel older builds at milestones | Lab 10 | `milestone()` |

---

## 🐙 Git & Source Control

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **git** | Clone/pull from Git repos | All | `git url: 'https://...'` |
| **git-parameter** | Git branch/tag as build parameter | Lab 08 | Parameter type: `GitParameterDefinition` |
| **github** | GitHub webhook integration | Lab 08 | Trigger: `githubPush()` |
| **github-branch-source** | Multi-branch pipeline from GitHub | Lab 08 | Automatic branch discovery |

---

## 🐳 Docker & Containers

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **docker-workflow** | Docker commands in pipeline | Lab 07 | `docker.image('node:18').inside { }` |
| **docker-plugin** | Use Docker containers as agents | Lab 07 | Agent template configuration |
| **docker-commons** | Shared Docker utilities | Lab 07 | Docker registry credentials |

---

## ☸️ Kubernetes

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **kubernetes** | Run agents as K8s pods | Lab 12 | `agent { kubernetes { yaml '''...''' } }` |
| **kubernetes-credentials** | Store kubeconfig as credential | Lab 12 | Credential type: Kubernetes config |
| **kubernetes-client-api** | K8s API client library | Lab 12 | Used internally by kubernetes plugin |

---

## 🔐 Authentication & Authorization

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **ldap** | LDAP/Active Directory authentication | Lab 14 | Configure in Global Security |
| **matrix-auth** | Fine-grained permission matrix | Lab 14 | Per-user/group permissions |
| **role-strategy** | Role-based access control | Lab 14 | Create roles → assign to users/groups |
| **authorize-project** | Per-project build authorization | Lab 09 | Run build as specific user |

---

## ⚙️ Configuration as Code (JCasC)

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **configuration-as-code** | Configure Jenkins entirely via YAML | Lab 11 | `jenkins.yaml` in `$JENKINS_HOME/casc_configs/` |

Example `jenkins.yaml`:
```yaml
jenkins:
  systemMessage: "Configured via JCasC"
  securityRealm:
    local:
      users:
        - id: "admin"
          password: "admin"
  authorizationStrategy:
    loggedInUsersCanDoAnything: {}
```

---

## 🧹 Workspace & Cleanup

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **ws-cleanup** | Clean workspace before/after build | Lab 09 | `cleanWs()` in `post { always {} }` |

---

## 📢 Notifications

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **slack** | Send build notifications to Slack | Lab 11 | `slackSend channel: '#builds', message: 'Done'` |
| **email-ext** | Advanced email notifications | Lab 11 | `emailext subject: '...', body: '...'` |

---

## 📊 Testing & Code Quality

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **junit** | Parse JUnit XML test results | Lab 06, 15 | `junit 'target/surefire-reports/*.xml'` |
| **htmlpublisher** | Publish HTML reports | Lab 06 | `publishHTML(target: [...])` |
| **cobertura** | Code coverage reports | Lab 15 | `cobertura coberturaReportFile: '...'` |
| **warnings-ng** | Static analysis warnings | Lab 15 | `recordIssues tools: [java()]` |
| **coverage** | Unified coverage reporting | Lab 15 | `recordCoverage tools: [[...]]` |

---

## 🔵 Blue Ocean (Modern UI)

| Plugin | What It Does | Used In Lab | How to Access |
|--------|-------------|-------------|---------------|
| **blueocean** | Modern pipeline visualization | All | `http://localhost:8080/blue` |

Features:
- Visual pipeline editor (drag & drop stages)
- Better parallel stage visualization
- GitHub/Bitbucket integration
- Personalized dashboard

---

## 🛠️ Utility Plugins

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **ansicolor** | Color output in console | All | `ansiColor('xterm') { sh 'ls --color' }` |
| **timestamper** | Timestamps in console output | All | `timestamps { ... }` |
| **rebuild** | Re-run build with same parameters | All | "Rebuild" button on build page |
| **http_request** | Make HTTP calls from pipeline | Lab 08 | `httpRequest url: 'http://...'` |
| **job-dsl** | Create jobs programmatically | Lab 11 | DSL script to generate pipelines |
| **ssh-agent** | SSH key forwarding in pipeline | Lab 03 | `sshagent(['my-ssh-key']) { }` |
| **throttle-concurrents** | Limit concurrent builds | Lab 05 | `throttle(['my-category']) { }` |

---

## 🏗️ Build Tools

| Plugin | What It Does | Used In Lab | Example Usage |
|--------|-------------|-------------|---------------|
| **gradle** | Gradle build integration | N/A | `sh './gradlew build'` |
| **ant** | Apache Ant build integration | N/A | `ant target: 'build'` |

---

## 📥 How to Install

### Method 1: Auto-install script (Recommended)
```bash
./install-plugins.sh
# Installs everything in ~3 minutes, restarts Jenkins automatically
```

### Method 2: Pre-built Docker image
```bash
docker build -t jenkins-labs .
docker run -d -p 8080:8080 --name jenkins-labs jenkins-labs
# All plugins pre-installed! Login: admin/admin
```

### Method 3: Jenkins CLI
```bash
docker exec jenkins-lab-01 jenkins-plugin-cli --plugins \
  docker-workflow credentials-binding pipeline-groovy-lib \
  github kubernetes ldap blueocean slack ws-cleanup \
  configuration-as-code matrix-auth role-strategy
docker restart jenkins-lab-01
```

### Method 4: From Jenkins UI
1. Go to **Manage Jenkins** → **Plugins** → **Available plugins**
2. Search for each plugin name
3. Check the box → Click **"Install"**
4. Restart Jenkins when all are installed

---

## 🔗 Plugin Documentation Links

| Plugin | Official Docs |
|--------|--------------|
| Docker Pipeline | https://plugins.jenkins.io/docker-workflow/ |
| Kubernetes | https://plugins.jenkins.io/kubernetes/ |
| Blue Ocean | https://plugins.jenkins.io/blueocean/ |
| Configuration as Code | https://plugins.jenkins.io/configuration-as-code/ |
| Credentials Binding | https://plugins.jenkins.io/credentials-binding/ |
| Pipeline Shared Libraries | https://www.jenkins.io/doc/book/pipeline/shared-libraries/ |
| GitHub Integration | https://plugins.jenkins.io/github/ |
| LDAP | https://plugins.jenkins.io/ldap/ |
| Matrix Authorization | https://plugins.jenkins.io/matrix-auth/ |
| Slack Notification | https://plugins.jenkins.io/slack/ |
| JUnit | https://plugins.jenkins.io/junit/ |
| Warnings NG | https://plugins.jenkins.io/warnings-ng/ |
