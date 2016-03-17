target = null

beforeEach ->
  target = null

describe 'Change Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onChange').and.callFake ->
      target = @
      false

    fixture """
      <div id="parent" data-controller="MyLib">
        <form id="test" data-on-change="onChange">
          <input id="child" type="text" name="test" value="test" />
        </form>
      </div>
      """

  it 'should handle changes on the element', ->
    $('#test').change()
    expect(MyLib.onChange).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should handle changes on a child element', ->
    $('#child').change()
    expect(MyLib.onChange).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should ignore changes on a parent element', ->
    $('#parent').change()
    expect(MyLib.onChange).not.toHaveBeenCalled()
