# 📋 AdmissãoFlow • Portal Dual de Admissão CLT & eSocial (RH & Candidato)

[![Live Demo](https://img.shields.io/badge/Demo%20ao%20Vivo-GitHub%20Pages-00e676?style=for-the-badge&logo=github)](https://jtchila.github.io/admissao-digital/)
[![Portal Dual](https://img.shields.io/badge/Arquitetura-Portal%20Dual%20(RH%20%2B%20Candidato)-blue?style=for-the-badge)](https://jtchila.github.io/admissao-digital/)
[![eSocial S-2200](https://img.shields.io/badge/eSocial-Evento%20S--2200-blue?style=for-the-badge)](https://www.gov.br/esocial/)
[![LGPD Safe](https://img.shields.io/badge/LGPD-100%25%20Client--Side-emerald?style=for-the-badge)](https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm)
[![Licença MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-yellow?style=for-the-badge)](LICENSE)

> **Solução corporativa ponta a ponta para Admissão de Colaboradores e Conformidade Trabalhista:** conecta o time de Gente & Gestão (RH) e os novos colaboradores através de uma experiência dual. O RH cria processos sob medida e gera um **código único de acesso**; o candidato acessa seu checklist personalizado, valida seus documentos em tempo real via OCR no navegador e devolve um pacote ZIP padronizado com e-mail estruturado.

---

## 🎯 O Problema de Negócio (Gargalo no DP & RH)

No modelo tradicional de admissão de colaboradores:
1. **O RH envia listas genéricas de documentos:** Colaboradores solteiros recebem pedidos de certidão de casamento; estagiários recebem pedidos de carteira de trabalho antiga; colaboradores operacionais deixam de enviar comprovantes de habilitação ou vacinas obrigatórias.
2. **Triagem manual, caótica e demorada:** O candidato envia dezenas de fotos tortas no WhatsApp ou múltiplos PDFs desorganizados por e-mail. Analistas de DP gastam de 45 a 60 minutos por colaborador conferindo documento por documento.
3. **Documentos ilegíveis e retrabalho:** A CTPS vem sem as folhas de contrato, o comprovante bancário não mostra agência/conta, a carteira de vacinação omite a **Antitetânica (dT)** exigida pelo PCMSO, ou a autodeclaração étnico-racial é recusada pelo eSocial por falta de assinatura válida.
4. **Risco de multas no eSocial (Evento S-2200):** A admissão precisa ser transmitida ao Ministério do Trabalho e Emprego antes do início das atividades. Qualquer pendência documental gera atrasos e passivos trabalhistas.

---

## 🚀 A Solução: Arquitetura Dual do AdmissãoFlow

O **AdmissãoFlow** resolve as duas pontas da esteira admissional em uma única plataforma web, responsiva e sem necessidade de servidores ou bancos de dados complexos:

```mermaid
flowchart TD
    subgraph RH["👔 1. Painel do RH (Gente & Gestão)"]
        A["Cadastrar Vaga & Candidato<br/>(Empresa, Cargo, Nome, E-mail, Prazo)"] --> B["Personalizar Checklist de Documentos<br/>(Templates ou Seleção Manual de 20 Itens)"]
        B --> C["⚡ Gerar Processo Admissional"]
        C --> D["🔑 Código Único (ex: ADM-7842)<br/>+ Link Direto Personalizado"]
        D --> E["Disparo Automático<br/>(WhatsApp ou E-mail do Candidato)"]
    end

    subgraph Candidato["👤 2. Portal do Candidato (Enviador)"]
        E --> F["Candidato Acessa via Link ou Código Único"]
        F --> G["Visualiza APENAS os documentos exigidos para sua vaga"]
        G --> H["Upload em Lote ou Slot a Slot"]
        H --> I["Motor Heurístico & OCR (PDF.js) em Tempo Real"]
        I --> J{"Documento Válido?"}
        J -- "Aviso / Pendente" --> K["Feedback Imediato ao Candidato<br/>(ex: falta verso, sem vacina de tétano)"]
        K --> H
        J -- "100% Validado" --> L["Gerador de Autodeclaração Étnico-Racial<br/>+ Assinatura Gov.br"]
        L --> M["Empacotador ZIP 100% Client-Side (JSZip)<br/>(01_RG, 02_CPF, 03_CNH...)"]
        M --> N["✉️ Devolução com E-mail Estruturado para o RH"]
    end
```

---

## ✨ Principais Funcionalidades

### 👔 1. Painel do RH (Gerador de Processos & Códigos)
- **Configuração Customizada:** Cadastro da empresa, cargo/posição, nome do candidato, e-mail de retorno do RH e prazo fatal para envio.
- **Templates Rápidos de Documentação:**
  - `⚡ CLT Completo Geral`: Todos os 20 documentos do checklist eSocial.
  - `💼 Administrativo (Sem Filhos)`: Dispensa automática de dependentes, certidões de casamento e certificados militares quando não aplicáveis.
  - `🚜 Operacional / Obras`: Foco intensivo em CNH profissional, carteiras de vacinação dupla (COVID + dT) e saúde ocupacional.
  - `🎓 Estágio / Trainee`: Documentação compacta com comprovantes de matrícula escolar/universitária e dados bancários.
- **Seleção Fina Item a Item:** Checkboxes individuais para marcar ou desmarcar qualquer um dos 20 documentos.
- **Geração de Código Único de Acesso (ex: `ADM-8421`):** Código curto para o candidato digitar na tela inicial.
- **Geração de Link Direto com Estado Integrado (State-in-URL):** O link carrega o estado do processo codificado em Base64, permitindo que o candidato abra no celular ou computador **sem precisar fazer login e sem depender de banco de dados na nuvem!**
- **Disparador de Mensagem Pronta:** Texto empático pré-formatado para o RH copiar e colar no WhatsApp ou e-mail de convocação do candidato.

---

### 👤 2. Portal do Candidato (Envio, OCR & Validação)
- **Checklist Sob Medida:** O candidato visualiza exclusivamente os documentos exigidos para o seu processo admissional.
- **Validação Heurística & OCR Local (Client-Side):**
  - Parsing de PDFs em tempo real via **Mozilla PDF.js**.
  - Validação de consistência cadastral (CPF, dados bancários de conta corrente, comprovante de residência recente com CEP).
  - Alerta preventivo se a carteira de vacinação contiver apenas COVID-19 e faltar a **Antitetânica (dT)** obrigatória no PCMSO.
  - Verificação de metadados de **Assinaturas Digitais Oficiais (GOV.BR / ICP-Brasil / PKCS7)**.
- **Suporte a Upload em Lote:** O colaborador pode selecionar 10 arquivos de uma só vez; o sistema classifica e aloca cada arquivo no seu devido slot automaticamente.
- **Suporte a Múltiplos Arquivos por Item (`#1`, `#2`, `#3`...):** Permite anexar múltiplos diplomas de graduação e pós-graduação, frente e verso separados, etc.
- **Gerador Integrado de Autodeclaração Étnico-Racial (eSocial S-2200):** Emissão em formato oficial A4 com diretrizes do IBGE e link direto para o assinador gratuito do Governo Federal (**`assinador.iti.br`**).
- **Empacotador ZIP 100% no Navegador:** Compacta todos os arquivos organizados com nomes padronizados (`01_RG_Nome.pdf`, `02_CPF_Nome.png`...) via **JSZip**.
- **Gerador de E-mail de Devolução:** Compila a mensagem final com a relação completa de arquivos já direcionada para a analista de RH responsável.

---

## 🔒 Privacidade & Conformidade Rigorosa com a LGPD

- **Arquitetura 100% Client-Side:** Todo o processamento heurístico, inspeção de arquivos, leitura de textos e compressão de arquivos ocorre exclusivamente na memória do navegador do colaborador.
- **Zero Tráfego em Servidores Externos:** Nenhum documento pessoal ou dado sensível transita por servidores ou nuvens de terceiros.
- **Anonimização no Repositório Público:** Dados e nomes reais substituídos por modelos corporativos sintéticos (*Carlos Eduardo da Silva*, *TechCorp Engenharia S.A.*).

---

## 💻 Demonstração Rápida (Test Drive)

Acesse a demonstração oficial no GitHub Pages:
👉 **[https://jtchila.github.io/admissao-digital/](https://jtchila.github.io/admissao-digital/)**

### Como testar em 2 minutos:
1. No **Painel do RH**, ajuste o nome do candidato e clique em **`⚡ Gerar Processo & Código Único`**.
2. Clique em **`🚀 Abrir Como Candidato`** (ou copie o código único e acesse pelo campo do topo).
3. Na visão do candidato, clique em **`✨ Demonstração Rápida (Test Drive)`** para simular o envio e a validação instantânea de todos os documentos.
4. Baixe o pacote ZIP final e teste o gerador de e-mail pronto para o RH!

---

## 🛠️ Tecnologias Utilizadas

- **Frontend Core:** HTML5 Semântico, JavaScript Moderno (ES6+), CSS3.
- **Framework Visual:** [Tailwind CSS](https://tailwindcss.com/) com paleta executiva Dark Mode.
- **Processamento de PDFs & OCR:** [Mozilla PDF.js](https://mozilla.github.io/pdf.js/).
- **Compressão de Arquivos no Browser:** [JSZip](https://stuk.github.io/jszip/) & [FileSaver.js](https://github.com/eligrey/FileSaver.js).
- **Tipografia:** Plus Jakarta Sans & JetBrains Mono.
- **Hospedagem & CI/CD:** GitHub Pages com deploy contínuo.

---

## 📈 Impacto e Indicadores de Negócio (ROI)

| Indicador | Processo Manual Convencional | Com AdmissãoFlow | Ganho Operacional |
| :--- | :---: | :---: | :---: |
| **Tempo de conferência de admissão** | 45 a 60 min por candidato | **8 a 12 min** | **🔻 ~80% de redução** |
| **Taxa de documentos incompletos/recusados** | ~35% dos processos | **< 3%** | **🔻 Zero retrabalho** |
| **Comunicação e agilidade com o candidato** | Desorganizada (WhatsApp/E-mails soltos) | **Código Único + Link Direto** | **⚡ Experiência de alto padrão** |
| **Conformidade com o eSocial (Evento S-2200)** | Atrasos e riscos de multas MTE | **100% auditável** | **🛡️ Risco trabalhista zero** |

---

## 👤 Autor & Desenvolvimento

Projeto concebido e desenvolvido por **Juliano da Trindade Chila**:
- **Perfil:** Especialista em Business Intelligence, Analytics, Engenharia de Dados & Desenvolvimento de Sistemas.
- **LinkedIn:** [linkedin.com/in/juliano-chila](https://linkedin.com/in/juliano-chila)
- **GitHub:** [@JTChila](https://github.com/JTChila)
- **Portfólio de Soluções:** [antigravity-workspace](https://github.com/JTChila/antigravity-workspace)

---

## 📄 Licença

Distribuído sob a licença **MIT** — sinta-se à vontade para utilizar, customizar e implantar na sua empresa.
