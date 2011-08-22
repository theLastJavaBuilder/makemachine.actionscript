package makemachine.parameters
{
	public interface IGenerator
	{
		function generate( position:int ):Number;
		function reset():void;
	}
}