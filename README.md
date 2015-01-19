hxE
===

A simple entity system written in Haxe, based on the Artemis ES:
http://gamadu.com/artemis/

Installation
--

`haxelib git hxE https://github.com/PDeveloper/hxE.git`

Limitations
--
The number of components you can use is limited, since each component requires a unique bit flag. The default is 32, since the default BitSet is the SingleBitSet. You can define compiler flags: `-D hxEDoubleBit` which will increase the limit to 64 components, or `-D hxELargeBit` which allows unlimited components, but is also slower (relatively by a lot, but not sure if noticeable).

Docs
--

I'll be adding to the Wiki in a few days. For now, see the samples included!

Read up on Entity systems! (There are 5 parts to the below link)
http://t-machine.org/index.php/2007/09/03/entity-systems-are-the-future-of-mmog-development-part-1/

License
--
MIT - see LICENSE.txt
(If licenses are ever a problem to anyone, hit me up!)
