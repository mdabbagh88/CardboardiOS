//
//  SQUWatermelonLandRenderer.m
//  Cardboard
//
//  Created by Tristan Seifert on 1/17/15.
//  Copyright (c) 2015 Tristan Seifert. All rights reserved.
//

#import "SQUWatermelonLandRenderer.h"

#define kNodeNameCube @"kNodeNameCube"
#define kNodeNameSphere @"kNodeNameSphere"

@implementation SQUWatermelonLandRenderer

/**
 * initialises the nodes to be added to the scene
 */
- (void) addNodesToScene:(SCNScene *) scene {
	
	// create a single cube
	CGFloat boxSide = 10.0;
	SCNBox *box = [SCNBox boxWithWidth:boxSide
								height:boxSide
								length:boxSide
						 chamferRadius:0];
	box.name = kNodeNameCube;
	
	SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
	boxNode.position = SCNVector3Make(0, 0, 0);
	
	
	// load the watermelon texture
	SCNMaterial *watermelonTexture = box.firstMaterial;
	watermelonTexture.diffuse.contents = [UIImage imageNamed:@"watermelon"];
	watermelonTexture.specular.contents = [UIColor colorWithWhite:0.1 alpha:1.0];
	box.materials = @[watermelonTexture];
	
	[scene.rootNode addChildNode:boxNode];
	
	// add some animation to the cube
	CABasicAnimation *boxRotation =
	[CABasicAnimation animationWithKeyPath:@"transform"];
	boxRotation.fromValue =
	[NSValue valueWithSCNMatrix4:SCNMatrix4Rotate(boxNode.transform, 0, 1, 1, 0)];
	boxRotation.toValue =
	[NSValue valueWithSCNMatrix4:SCNMatrix4Rotate(boxNode.transform, M_PI, 1, 1, 0)];
	boxRotation.timingFunction =
	[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	boxRotation.repeatCount = INFINITY;
	boxRotation.duration = 2.0;
	
	[boxNode addAnimation:boxRotation
				   forKey:@"RotateCubular"];
	
	// create a sphere
	SCNSphere *sphere = [SCNSphere sphereWithRadius:5];
	sphere.name = kNodeNameSphere;
	
	SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
	sphereNode.position = SCNVector3Make(-5, 13, -8);
	sphere.materials = @[watermelonTexture];
	
	[scene.rootNode addChildNode:sphereNode];
	
	// create skybox
	scene.background.contents = @[@"skybox_right", @"skybox_left", @"skybox_top", @"skybox_bottom", @"skybox_back", @"skybox_front"];

}

- (void) willRenderScene:(SCNScene *) scene {
	
}

@end
