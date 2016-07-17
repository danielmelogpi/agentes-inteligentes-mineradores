/**
* Name: Experimento1
* Author: daniel
* Description: Experimento com agentes explorando o mundo
*/

model Experimento1 

global {
	int num_explorador <- 20;
	int num_base <- 1;
	init {
		create explorador number: num_explorador;
	}
}

species explorador {
	
	float size <- 1.0 ;
	rgb color <- #blue;
	base_central base <- one_of(base_central);
		
	aspect base {
		draw circle(size) color: color;
	}

}

species base_central {

	rgb color <- #red;
	float size <- 5.0 ;
	
	aspect base {
		draw  circle(size) color: color;
	}
	
}

experiment experimento type: gui {
	
	parameter "Numero de exploradores: " var: num_explorador min: 1 max: 100 category: "explorador" ;
	output {
		display main_display {
			species explorador aspect: base ;
		}
	}
}
