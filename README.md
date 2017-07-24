# Multilingual
 
 >**代码来源于`Maxim Bilan`[地址](https://github.com/maximbilan/ios_language_manager.git)**,该代的主要功能是实现应用内切换语言(不需要重启应用)。**脚本来源于`mokai`[地址](http://www.cocoachina.com/ios/20151120/14258.html)**,该脚本的功能是实现编译的时对storyboard或xib对应的.strings文件中增量添加`key,value`,在`mokai`的脚本上增加处理工程中所有的`storyboard和xib`,`mokai`还有一篇[国际化的文章](http://www.cocoachina.com/ios/20151120/14258.html)。
 
## 使用方法
1.`podfile` 引入Multilingual
		
	pod 'Multilingual', :git => 'https://github.com/JustinYangJing/Multilingual.git'
	
2.为项目的`target`添加编译时运行的脚本`AutoGenStrings.py`

	python ${SRCROOT}/Pods/Multilingual/Multilingual/AutoGenStrings.py ${SRCROOT}/${TARGET_NAME}
<center>
<img src="https://raw.githubusercontent.com/JustinYangJing/Resource/master/Image/Multilingual/1.gif" width="100%" />
</center>

3.在`Appdelegate`中引入`LanguageManager.h`并使用`[LanguageManager setupCurrentLanguage];`初始化

4.在项目中使用`NSLocalizedString`或`NSLocalizedStringFromTable`来索引key所对应的当前语言的值，如果使用中文作为key，那中文对应的*.strings文件可不实现。

5.在切换语言的VC中使用`+ (void)saveLanguageByIndex:(NSInteger)index;
` 或者`+ (void)saveLanguageByCode:(NSString *)language`切换语言，并重设`Appdelegate.window.rootViewController`