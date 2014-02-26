target = null

beforeEach ->
  target = null

describe 'Change Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onChange').andCallFake -> target = @
    fixture """
      <div id="parent">
        <form id="test" data-on-change="MyLib.onChange">
          <input id="child" type="text" name="test" value="test" />
        </form>
      </div>
      """

  it 'should handle changes on the element', ->
    expect(MyLib.onChange).not.toHaveBeenCalled()
    $('#test').change()
    expect(MyLib.onChange).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should handle changes on a child element', ->
    expect(MyLib.onChange).not.toHaveBeenCalled()
    $('#child').change()
    expect(MyLib.onChange).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should ignore changes on a parent element', ->
    expect(MyLib.onChange).not.toHaveBeenCalled()
    $('#parent').change()
    expect(MyLib.onChange).not.toHaveBeenCalled()
