package makemachine.utils
{
	/**
	 * Replaces an html tag with a span tag.
	 */
	public function replaceTagWithSpan( string:String, tag:String, spanTagClass:String ):String
	{
		// -- begin tag
		var pattern:RegExp = new RegExp( '<' + tag + '>', 'gi' );
		var result:String = string.replace( pattern, '<span class="' + spanTagClass + '">' );
		
		// -- end tag
		pattern = new RegExp( '</' + tag + '>', 'gi' );
		result = result.replace( pattern, '</span>' );
		
		return result;
	}
}