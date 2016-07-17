/**
* Name: explorador
* Author: daniel
* Description: Unidade capaz de andar pelo mundo para descobrir pontos interessantes com minérios valiosos
* Tags: Tag1, Tag2, TagN
*/


model explorador

/* Insert your model definition here */

species explorador {
	
	float size <- 1.0 ;
	rgb color <- #blue;
		
	aspect base {
		draw circle(size) color: color ;
	}

}

