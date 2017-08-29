//
//  DVMPokemonController.m
//  PokedexHybridiOS14
//
//  Created by Garrett Lyons on 8/29/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import "DVMPokemonController.h"
#import "DVMPokemon.h"
#import "PokedexHybridiOS14-Swift.h"

static NSString * const baseURLString = @"http://pokeapi.co/api/v2/pokemon";

@implementation DVMPokemonController

+ (void)fetchPokemonForSearchTerm:(NSString *)searchTerm completion:(void (^)(DVMPokemon * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString: baseURLString];
    
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:[searchTerm lowercaseString]];
    
    [NetworkController performRequestFor:searchURL httpMethod:@"GET" urlParameters:nil body:nil completion:^(NSData * data, NSError * error) {
        
        if (error) {
            NSLog(@"Error getting pokemon for toast: %@", error.localizedDescription);
            completion(nil)
            return;
        }
        
        if (!data) {
            NSLog(@"Error no data returned from data task");
            completion(nil);
            return;
        }
        
        // Turning object into JSONDictionary
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Could not serilize JSON data into a NSDictionary %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        DVMPokemon *pokemon = [[DVMPokemon alloc] initWithDictionary:jsonDictionary];
        
        completion(pokemon);
    }];
}

@end















