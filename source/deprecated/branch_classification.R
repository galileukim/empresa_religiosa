##################################################################
# CLASSIFY CHURCHES
##################################################################

load("~/Dropbox/Working_papers/BRA_religious_education/data/rais+classification/igrejas_2014_RAISCl.Rda")

head(igrejas_2014cl)

# classify denomination
igrejas_2014cl$Razão.Social <- as.character(igrejas_2014cl$Razão.Social)
igrejas_2014cl$Razão.Social <- trimws(igrejas_2014cl$Razão.Social, "both")

igrejas_2014cl$denomin_type[grepl("PRESBITERIANA", igrejas_2014cl$Razão.Social)] <- "PRESBITERIAN"
igrejas_2014cl$denomin_type[grepl("PRESBETERIANO", igrejas_2014cl$Razão.Social)] <- "PRESBITERIAN"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="PRESBITERIAN"])] <- "PRESBITERIAN"

igrejas_2014cl$denomin_type[grepl("METODISTA", igrejas_2014cl$Razão.Social)] <- "METHODIST"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="METHODIST"])] <- "METHODIST"

igrejas_2014cl$denomin_type[grepl("ADVENTISTA", igrejas_2014cl$Razão.Social)] <- "ADVENTIST"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="ADVENTIST"])] <- "ADVENTIST"

igrejas_2014cl$denomin_type[grepl("DIOCESE", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("DIOCESANA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("ARQUID", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("FILHAS", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("IRMAS", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("MITRA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("CATOLICA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("JESUITAS", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("SALESIANA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("CARMELITA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("PAROQUIA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("PRELAZIA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("MISSIONARIAS", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("CATOLICO", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("FRANCISCANA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("CONFERENCIA NACIONAL DOS BISPOS DO BRASIL", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("CONSELHO INDIGENISTA MISSIONARIO", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[grepl("COMISSAO PASTORAL DA TERRA", igrejas_2014cl$Razão.Social)] <- "CATHOLIC"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="CATHOLIC"])] <- "CATHOLIC"


igrejas_2014cl$denomin_type[grepl("ASSEMBLEIA DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASSEMB DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASSEMBL DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASSEM DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASSMBLEIA DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASSEMB. DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASS DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[grepl("ASS DE DEUS", igrejas_2014cl$Razão.Social)] <- "ASSEMBLIES OF GOD"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="ASSEMBLIES OF GOD"])] <- "ASSEMBLIES OF GOD"

igrejas_2014cl$denomin_type[grepl("BATISTA", igrejas_2014cl$Razão.Social)] <- "BAPTIST"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="BAPTIST"])] <- "BAPTIST"


igrejas_2014cl$denomin_type[grepl("EXERCITO DE SALVACAO", igrejas_2014cl$Razão.Social)] <- "SALVATION ARMY"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="SALVATION ARMY"])] <- "SALVATION ARMY"


igrejas_2014cl$denomin_type[grepl("LUTERANA", igrejas_2014cl$Razão.Social)] <- "LUTERAN"
igrejas_2014cl$denomin_type[grepl("LUTER", igrejas_2014cl$Razão.Social)] <- "LUTERAN"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="LUTERAN"])] <- "LUTERAN"

igrejas_2014cl$denomin_type[grepl("ESPIRITA", igrejas_2014cl$Razão.Social)] <- "ESPIRITA"
igrejas_2014cl$denomin_type[grepl("UMBANDISTA", igrejas_2014cl$Razão.Social)] <- "ESPIRITA"
igrejas_2014cl$denomin_type[grepl("CULTOS AFROS", igrejas_2014cl$Razão.Social)] <- "ESPIRITA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="ESPIRITA"])] <- "ESPIRITA"

igrejas_2014cl$denomin_type[grepl("IGREJA DO EVANGELHO QUADRANGULAR", igrejas_2014cl$Razão.Social)] <- "IEQ"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IEQ"])] <- "IEQ"

igrejas_2014cl$denomin_type[grepl("IGREJA UNIVERSAL DO REINO DE DEUS", igrejas_2014cl$Razão.Social)] <- "IURD"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IURD"])] <- "IURD"

igrejas_2014cl$denomin_type[grepl("SARA NOSSA TERRA", igrejas_2014cl$Razão.Social)] <- "SARA NOSSA TERRA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="SARA NOSSA TERRA"])] <- "SARA NOSSA TERRA"

igrejas_2014cl$denomin_type[grepl("IGREJA INTERNACIONAL DA GRACA DE DEUS", igrejas_2014cl$Razão.Social)] <- "IGREJA INTERNACIONAL DA GRACA DE DEUS"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA INTERNACIONAL DA GRACA DE DEUS"])] <- "IGREJA INTERNACIONAL DA GRACA DE DEUS"

igrejas_2014cl$denomin_type[grepl("IGREJA MUNDIAL DO PODER DE DEUS", igrejas_2014cl$Razão.Social)] <- "IGREJA MUNDIAL DO PODER DE DEUS"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA MUNDIAL DO PODER DE DEUS"])] <- "IGREJA MUNDIAL DO PODER DE DEUS"

igrejas_2014cl$denomin_type[grepl("MARANATA PES", igrejas_2014cl$Razão.Social)] <- "IGREJA CRISTA MARANATA PES"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA CRISTA MARANATA PES"])] <- "IGREJA CRISTA MARANATA PES"

igrejas_2014cl$denomin_type[grepl("ASSOCIACAO BRASILEIRA D A IGREJA DE JESUS CRISTO DOS", igrejas_2014cl$Razão.Social)] <- "JESUS CRISTO DOS"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="JESUS CRISTO DOS"])] <- "JESUS CRISTO DOS"

igrejas_2014cl$denomin_type[grepl("PENTECOSTAL", igrejas_2014cl$Razão.Social)] <- "PENTECOSTAL"
igrejas_2014cl$denomin_type[grepl("IGREJA PENT", igrejas_2014cl$Razão.Social)] <- "PENTECOSTAL"
igrejas_2014cl$denomin_type[grepl("IGREJA EVANG PENT", igrejas_2014cl$Razão.Social)] <- "PENTECOSTAL"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="PENTECOSTAL"])] <- "PENTECOSTAL"

igrejas_2014cl$denomin_type[grepl("CONGREGACAO CRISTA NO BRASIL", igrejas_2014cl$Razão.Social)] <- "CONGREGACAO CRISTA NO BRASIL"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="CONGREGACAO CRISTA NO BRASIL"])] <- "CONGREGACAO CRISTA NO BRASIL"


igrejas_2014cl$denomin_type[grepl("IGREJA APOSTOLICA", igrejas_2014cl$Razão.Social)] <- "IGREJA APOSTOLICA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA APOSTOLICA"])] <- "IGREJA APOSTOLICA"


igrejas_2014cl$denomin_type[grepl("IGREJA DE NOSSO SENHOR JESUS CRISTO", igrejas_2014cl$Razão.Social)] <- "IGREJA DE NOSSO SENHOR JESUS CRISTO"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA DE NOSSO SENHOR JESUS CRISTO"])] <- "IGREJA DE NOSSO SENHOR JESUS CRISTO"


igrejas_2014cl$denomin_type[grepl("COMUNIDADE CRISTA PAZ E VIDA", igrejas_2014cl$Razão.Social)] <- "COMUNIDADE CRISTA PAZ E VIDA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="COMUNIDADE CRISTA PAZ E VIDA"])] <- "COMUNIDADE CRISTA PAZ E VIDA"


igrejas_2014cl$denomin_type[grepl("ASSOCIACAO BRASIL SGI", igrejas_2014cl$Razão.Social)] <- "ASSOCIACAO BRASIL SGI"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="ASSOCIACAO BRASIL SGI"])] <- "ASSOCIACAO BRASIL SGI"


igrejas_2014cl$denomin_type[grepl("INSTITUTO BIBLICO BETEL BRASILEIRA", igrejas_2014cl$Razão.Social)] <- "INSTITUTO BIBLICO BETEL BRASILEIRA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="INSTITUTO BIBLICO BETEL BRASILEIRA"])] <- "INSTITUTO BIBLICO BETEL BRASILEIRA"


igrejas_2014cl$denomin_type[grepl("SUKYO MAHIKARI DO BRASIL", igrejas_2014cl$Razão.Social)] <- "SUKYO MAHIKARI DO BRASIL"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="SUKYO MAHIKARI DO BRASIL"])] <- "SUKYO MAHIKARI DO BRASIL"


igrejas_2014cl$denomin_type[grepl("MOVIMENTO GNOSTICO CRISTAO UNIVERSAL DO BRASIL NA NO", igrejas_2014cl$Razão.Social)] <- "MOVIMENTO GNOSTICO CRISTAO UNIVERSAL DO BRASIL NA NO"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="MOVIMENTO GNOSTICO CRISTAO UNIVERSAL DO BRASIL NA NO"])] <- "MOVIMENTO GNOSTICO CRISTAO UNIVERSAL DO BRASIL NA NO"


igrejas_2014cl$denomin_type[grepl("IGREJA DE DEUS NO BRASIL", igrejas_2014cl$Razão.Social)] <- "IGREJA DE DEUS NO BRASIL"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA DE DEUS NO BRASIL"])] <- "IGREJA DE DEUS NO BRASIL"


igrejas_2014cl$denomin_type[grepl("IGREJA MESSIANICA MUNDIAL DO BRASIL", igrejas_2014cl$Razão.Social)] <- "IGREJA MESSIANICA MUNDIAL DO BRASIL"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA MESSIANICA MUNDIAL DO BRASIL"])] <- "IGREJA MESSIANICA MUNDIAL DO BRASIL"


igrejas_2014cl$denomin_type[grepl("IGREJA SINOS DE BELEM MISSAO DAS PRIMICIAS", igrejas_2014cl$Razão.Social)] <- "IGREJA SINOS DE BELEM MISSAO DAS PRIMICIAS"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA SINOS DE BELEM MISSAO DAS PRIMICIAS"])] <- "IGREJA SINOS DE BELEM MISSAO DAS PRIMICIAS"


igrejas_2014cl$denomin_type[grepl("IGREJA MISSIONARIA UNIDA", igrejas_2014cl$Razão.Social)] <- "IGREJA MISSIONARIA UNIDA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA MISSIONARIA UNIDA"])] <- "IGREJA MISSIONARIA UNIDA"

igrejas_2014cl$denomin_type[grepl("EVANGELICA", igrejas_2014cl$Razão.Social) & is.na(igrejas_2014cl$denomin_type)] <- "EVANGELICAL"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="EVANGELICAL"])] <- "EVANGELICAL"

igrejas_2014cl$denomin_type[grepl("ISLAMICO", igrejas_2014cl$Razão.Social) & is.na(igrejas_2014cl$denomin_type)] <- "MUSLIM"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="MUSLIM"])] <- "MUSLIM"

igrejas_2014cl$denomin_type[grepl("IGREJA CRISTA", igrejas_2014cl$Razão.Social) & is.na(igrejas_2014cl$denomin_type)] <- "IGREJA CRISTA"
igrejas_2014cl$denomin_type[igrejas_2014cl$CNPJ.Raiz %in% 
                              unique(igrejas_2014cl$CNPJ.Raiz[igrejas_2014cl$denomin_type=="IGREJA CRISTA"])] <- "IGREJA CRISTA"


table(igrejas_2014cl$denomin_type)
table(is.na(igrejas_2014cl$denomin_type))
igrejas_2014cl$Razão.Social[is.na(igrejas_2014cl$denomin_type)][2000:2200]
struct <- table(igrejas_2014cl$Razão.Social[is.na(igrejas_2014cl$denomin_type)])[table(igrejas_2014cl$Razão.Social[is.na(igrejas_2014cl$denomin_type)])>10]
struct
