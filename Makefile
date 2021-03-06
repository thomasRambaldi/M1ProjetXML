
clean:
	rm -r www
	rm ./java/*.class
	#~ rm www/*
	#~ rm intervenant*.html
	#~ rm unites*.html
	#~ rm parcours*.html
	#~ rm index.html
	#~ rm resultat.html
	
dtd:
# Commencez par préparer le document exemple.xml. 
# Vérifier la syntaxe de ce document avec la commande
	xmllint --noout newProjet.xml
	xmllint --valid --noout newProjet.xml
	
xsd:
#~ vérifiez la validité du document XML avec la commande
	xmllint --noout -schema projet.xsd newProjet.xml

xmltoxml:
	xsltproc xsl/xml_vers_xml.xsl donnees-master.xml > newProjet.xml

ancien:
# Utilisez la feuille de style pour transformer votre document XML en un document XHTML. 
# La commande xsltproc doit être utilisée pour appliquer un feuille de style XSL à un document XML.
	mkdir -p www
	xsltproc xsl/projet.xsl  projet.xml > www/index.html
	
web:
# Utilisez la feuille de style pour transformer votre document XML en un document XHTML. 
# La commande xsltproc doit être utilisée pour appliquer un feuille de style XSL à un document XML.
	mkdir -p www
	xsltproc xsl/projet.xsl  newProjet.xml > www/index.html

tidy:
# En fait, ce document ne respecte ni la norme XHTML, ni la norme HTML. 
# Corrigez le avec la commande tidy (le validateur HTML/XHTML du W3C) pour obtenir un document qui respecte la norme HTML du W3C (version en français) :
	tidy -im -utf8 www/*.html

# Produisez ensuite sa version XHTML 1.0 (version en français) avec la même commande :
	tidy -im -asxhtml -utf8 -indent www/*.html


xq:
	java -cp saxon/saxon9he.jar net.sf.saxon.Query indent=no xq.txt > www/xq.xhtml
	
java:
	javac partiejava/afficherUE.java
	java partiejava/afficherUE

.PHONY: java

all:
	make dtd 
	make xsd
	make web
	make xq
	make java
