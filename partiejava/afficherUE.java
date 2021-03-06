package partiejava;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


public class afficherUE {

	public static void main(String[] args) throws Exception {
		// création d'un document vide
		Document doc = DocumentBuilderFactory.newInstance()
				.newDocumentBuilder().newDocument();
		Document doc2 = DocumentBuilderFactory.newInstance()
				.newDocumentBuilder().newDocument();
		// préparer une usine à fabriquer les analyseurs DOM
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setValidating(true);
		factory.setIgnoringElementContentWhitespace(true);
		String debutFile = "ue";
		NodeList n;
		// construire une analyseur DOM
		doc =  factory.newDocumentBuilder().parse(debutFile+".xml");
		n = doc.getElementsByTagName("unite");

		//		for(int i=0; i<n.getLength(); i++)
		//			System.out.println(n.item(i).getFirstChild().getFirstChild().getNodeValue());

		Element racine = doc2.createElement("unites");
		Element nom = null ;
		for(int i=0; i<n.getLength(); i++){
			nom = doc2.createElement("nom");
			String attr = n.item(i).getFirstChild().getFirstChild().getNodeValue();
			nom.setTextContent(attr);
			racine.appendChild(nom);
		}	
		doc2.appendChild(racine);

		// sérialisation
		TransformerFactory myFactory = TransformerFactory.newInstance();
		Transformer transformer = myFactory.newTransformer();

		transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		

		transformer.transform(new DOMSource(doc2),new StreamResult(System.out));

		xsl(debutFile);
	}


	public static void xsl(String debutFile) throws TransformerException{

		// Créer une usine à "transformer"
		TransformerFactory factory = TransformerFactory.newInstance();

		// Un premier "transformer" simple
		Transformer analyseur = factory.newTransformer();

		// Lire le document XML et en faire une copie
		DOMResult xml = new DOMResult();
		analyseur.transform(new StreamSource(debutFile+".xml"), xml);
		DOMSource xmlSrc = new DOMSource(xml.getNode());
		analyseur.transform(xmlSrc, new StreamResult(debutFile+"2.xml") );

		// Un "transformer" processeur XSL
		Transformer xslt = factory.newTransformer( new StreamSource(debutFile+".xsl") );

		// appliquer la feuille XSLT
		DOMResult out = new DOMResult();
		xslt.transform(new DOMSource(xml.getNode()), out);

		// Serialiser out dans "test.out" en iso-8859-1
		analyseur.setOutputProperty(OutputKeys.INDENT, "yes");
		analyseur.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		analyseur.transform(new DOMSource(out.getNode()),
				new StreamResult("test.out"));	
	}
}


