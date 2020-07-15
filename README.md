# RewardDemo
Sort the Reward in the right Order. 



There are three types of rewards listed for this user.  ( Reward.benefit.type )

"OFFER"
"COUPON"
“CASHBACK”


/* Requirements

Consider you are provided with 3 plist/json files.

 File1 contains all CASHBACK cards info in random order. It will have cards with all states.
 File2 contains all OFFER_IN_OFFER cards info in random order. It will have cards with all states.
 File3 contains all COUPON cards info in random order. It will have cards with all states.
 
All card types are SCRATCH_CARD
 
 States:
    UNSCRATCHED
    OPENED
    EXPIRED
 
 Types:
    CASHBACK
    OFFER
    COUPON
 
 Rules to display:
    Display in 1 section of a collection view.
 
    All cards with UNSCRATCHED state should come first and should be sorted
    in the the order of their recent "expiresIn" and ones which are not expired.
	- If the ‘expiresAt’ is past current time then those cards should be considered as expired  

    All OFFER and COUPON cards with OPENED state should come next and
    should be sorted in the the order of their ‘useBy’ (closest to current time)
	- If the ‘useBy’ is past current time then those cards should be considered as expired  
 
    ALL CASHBACK cards with OPENED state should come next and
    should be sorted in the the order of “updatedAt".
        - for cash back types ‘useBy’ must ignored.
 
    ALL expired cards including EXPIRED by state, UNSCRATCHED (but expired) and OPENED (but expired) cards should come last and
    should be sorted in the the order of "updatedAt".
*/
