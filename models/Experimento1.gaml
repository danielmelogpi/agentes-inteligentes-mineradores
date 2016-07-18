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
	vegetation_cell myCell <- one_of (vegetation_cell) ; 
	list<vegetation_cell> minerios_encontados;
	
	init {
		location <- myCell.location;
	}
	
	reflex mover {
		myCell <- one_of(myCell.vizinhos);
		location <- myCell.location;
	}
		
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

grid vegetation_cell width: 50 height: 50 neighbours: 4 {
	
	float hasMinerio <- rnd(1000);
	rgb color <- (hasMinerio > 950)? #yellow: #black ;
	
//	float maxFood <- 1.0 ;
//	float foodProd <- (rnd(1000) / 1000) * 0.01 ;
//	float food <- (rnd(1000) / 1000) max: maxFood update: food + foodProd ;
//	rgb color <- rgb(int(255 * (1 - food)), 255, int(255 * (1 - food))) update: rgb(int(255 * (1 - food)), 255, int(255 *(1 - food))) ;
	list<vegetation_cell> vizinhos  <- (self neighbours_at 1);
}

experiment experimento type: gui {
	
	parameter "Numero de exploradores: " var: num_explorador min: 1 max: 100 category: "explorador" ;
	output {
		display main_display {
			grid vegetation_cell lines: #black ;
			species explorador aspect: base ;
		}
	}
	
}
